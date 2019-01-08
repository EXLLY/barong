# frozen_string_literal: true
class SessionsController < Devise::SessionsController
  prepend_before_action :otp_verify, if: :otp_enabled?, only: :create
  prepend_before_action :captcha_verify, if: :not_verified?, only: :create

  def create
    return redirect_to(action: :new) if resource_params[:email].blank?

    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)

    @otp_enabled = otp_enabled?
    #TODO
    # overiew

    super
  end

  def confirm
    self.resource = resource_class.new({"email"=>session[:email], "password"=>session[:pwd]})
  end

  def check_captcha
    unless captcha_verified?
    end
  end

  def exit_peatio
    redirect_to ENV['API_CORS_ORIGINS'] + "/signout"
  end
  
private

  def not_verified?
    session[:captcha] != true;
  end

  def captcha_verify
    if verify_recaptcha
      session[:captcha] = true;
    else
      redirect_to(action: :new)
    end
  end

  def otp_enabled?
    account_by_email&.otp_enabled
  end

  def otp_verify
    if params[:otp]
      return if Vault::TOTP.validate?(account_by_email.uid, params[:otp])
      set_flash_message! :alert, :wrong_otp_code
      redirect_to accounts_sign_in_confirm_path
    else
      session[:email] = resource_params[:email]
      session[:pwd] = resource_params[:password]
      redirect_to accounts_sign_in_confirm_path
    end
  rescue Vault::HTTPClientError => e
    redirect_to new_account_session_path, alert: "Vault error: #{e.errors.join}"
  end

  def account_by_email
    Account.kept.find_by_email(resource_params[:email])
  end

  def overiew
    token = jwt_for(current_account)
    api_get account_variables_url, token: token
    result = JSON.parse(response.body)
  end

  def account_variables_url
    url = URI.parse(ENV.fetch('PLATFORM_ROOT_URL'))
    url = URI.join(url, 'api/v2/accounts/')
  end
end

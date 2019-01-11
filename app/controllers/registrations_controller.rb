class RegistrationsController < Devise::RegistrationsController
  layout 'application', only: [:edit, :update]
  prepend_before_action :captcha_verify, if: :not_verified?, only: :create
  prepend_before_action :otp_verify, if: :otp_enabled?, only: :update
  def check_captcha
    unless captcha_verified?
    end
  end

  protected
  def after_inactive_sign_up_path_for(resource)
    notice_registNotice_path(email:params[:account][:email])
  end

private

  def not_verified?
    session[:captchaR] != true;
  end

  def captcha_verify
    if verify_recaptcha
      session[:captchaR] = true;
    else
      redirect_to(action: :new)
    end
  end

  def otp_enabled?
    current_account.otp_enabled
  end

  def otp_verify
    if params[:otp]
      return if Vault::TOTP.validate?(current_account.uid, params[:otp])
      set_flash_message! :alert, :wrong_otp_code
      redirect_to edit_account_registration_path
    end
  rescue Vault::HTTPClientError => e
    redirect_to edit_account_registration_path, alert: "Vault error: #{e.errors.join}"
  end

end
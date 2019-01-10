class PasswordsController < Devise::PasswordsController
  before_action :otp_verify, if: :otp_enabled?, only: :create

  def create
    if otp_enabled?&params[:otp].blank?
      redirect_to new_account_password_path(otp_enabled:true,email:resource_params[:email])
    else
      super
    end
  end
  def new
    @otp_enabled = params[:otp_enabled]
    @email = params[:email]
    super
  end

  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    accounts_resetNotice_path(email:params[:account][:email])
  end

  def after_resetting_password_path_for(resource)
    accounts_exit_peatio_path
  end

private

  def otp_enabled?
    account_by_email&.otp_enabled
  end

  def otp_verify
    if params[:otp]
      return if Vault::TOTP.validate?(account_by_email.uid, params[:otp])
      set_flash_message! :alert, :wrong_otp_code
      redirect_to new_account_password_path(otp_enabled:otp_enabled?,email:resource_params[:email])
    end
  rescue Vault::HTTPClientError => e
    redirect_to new_account_password_path, alert: "Vault error: #{e.errors.join}"
  end

  def account_by_email
    Account.kept.find_by_email(resource_params[:email])
  end
end
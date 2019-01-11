class RegistrationsController < Devise::RegistrationsController
  layout 'application', only: [:edit, :update]
  prepend_before_action :captcha_verify, if: :not_verified?, only: :create

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
end
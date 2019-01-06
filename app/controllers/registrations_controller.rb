class RegistrationsController < Devise::RegistrationsController
  layout 'application', only: [:edit]

  protected
  def after_inactive_sign_up_path_for(resource)
    notice_registNotice_path(email:params[:account][:email])
  end
end
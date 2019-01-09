class PasswordsController < Devise::PasswordsController
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    accounts_resetNotice_path(email:params[:account][:email])
  end

  def after_resetting_password_path_for(resource)
    accounts_exit_peatio_path
  end
end
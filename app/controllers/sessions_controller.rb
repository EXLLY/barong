# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  prepend_before_action :otp_verify, if: :otp_enabled?, only: :create

  def create
    if params[:geetest_challenge] != nil
      # geetest start
      sdk = Geetest.new(ENV['GEE_TEST_ID'], ENV['GEE_TEST_KEY'])
      # Make judgments based on the three parameters that are automatically passed in when the form is submitted.
      result = sdk.success_validate params[:geetest_challenge], params[:geetest_validate], params[:geetest_seccode]
      # If the man-machine verification fails, jump back to the login page
      Rails.logger.info("*****result#{result}")
      unless result
        return redirect_to(action: :new)
      end
      # geetest end
    end
    return redirect_to(action: :new) if resource_params[:email].blank?

    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    @otp_enabled = otp_enabled?
    super
  end

private

  def otp_enabled?
    account_by_email&.otp_enabled
  end

  def otp_verify
    return if Vault::TOTP.validate?(account_by_email.uid, params[:otp])

    set_flash_message! :alert, :wrong_otp_code
    redirect_to accounts_sign_in_confirm_path
  rescue Vault::HTTPClientError => e
    redirect_to new_account_session_path, alert: "Vault error: #{e.errors.join}"
  end

  def account_by_email
    Account.kept.find_by_email(resource_params[:email])
  end
end

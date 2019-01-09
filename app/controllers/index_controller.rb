# frozen_string_literal: true

class IndexController < ApplicationController
  def index
    return redirect_to new_account_session_url unless account_signed_in?

    # redirect_to security_path if current_account.level == 1
    # redirect_to security_path unless current_account.otp_enabled
    # redirect_to new_profile_path if current_account.level == 2 && current_account.documents.blank?
  end
  def error_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end

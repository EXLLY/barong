# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApiHelper
  protect_from_forgery with: :exception

  alias current_user current_account # CanCanCan expects current_user.

  rescue_from Vault::TOTP::Error, with: :vault_human_exception
  rescue_from Vault::VaultError, with: :vault_exception

  helper_method :domain_asset

  before_action :set_language

  before_action :configure_permitted_parameters, if: :devise_controller?


  def domain_asset(item)
    @website ||= Website.find_by_domain(request.domain)
    @website[item] unless @website.nil? || @website[item].nil?
  end

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: 'Not authorized' } }
  end

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :subscribed]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

private

  def vault_human_exception(exception)
    redirect_to index_path, alert: exception.message
  end

  def vault_exception(exception)
    Rails.logger.error "#{exception.class}: #{exception.message}"
    redirect_to index_path, alert: 'Something wrong with 2FA'
  end

  def set_language
    cookies[:lang] = params[:lang] unless params[:lang].blank?
    cookies[:lang].tap do |locale|
      I18n.locale = locale if locale.present? && I18n.available_locales.include?(locale.to_sym)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    ENV['API_CORS_ORIGINS']
  end
end

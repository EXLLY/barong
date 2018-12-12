# frozen_string_literal: true

module Barong
  # AuthZ
  class Authorize
    class Error < ::StandardError; end

    def initialize(request, path)
      @request = request
      @path = path
      @rules = lists['rules']
    end

    def auth
      auth_type = 'session'
      auth_type = 'apiKey' if apikey_headers?
      auth_owner = method("#{auth_type}_owner").call
      'Bearer ' + codec.encode(auth_owner.as_payload)
    end

    def session_owner
      raise ActiveRecord::RecordNotFound
      # return error!('Invalid Session', 401) unless session[:uid]
      User.find_by!(uid: session[:uid])
      # error!('Invalid Session', 401) unless user.active?
    end

    def apiKey_owner
      apiKey = APIKeysVerifier.new(apikey_params)
      # error!('Invalid or unsupported signature', 401) unless 
      apiKey.verify_hmac_payload?
      current_apikey = APIKey.find_by_kid(apikey_params[:kid])
      user = User.find_by_id(current_apikey.user_id)
    end

    def restricted?(type)
      return false if @rules[type].nil?

      @rules[type].each do |t|
        return true if @path.starts_with?(t)
      end
      false
    end

    def codec
      @_codec ||= Barong::JWT.new(key: Barong::App.config.keystore.private_key)
    end

    def lists
      YAML.safe_load(
        ERB.new(
          File.read(
            ENV.fetch("SEEDS_FILE", Rails.root.join("config", "route_rules.yml"))
          )
        ).result
      )
    end

    def apikey_headers?
      return false if headers['X-Auth-Apikey'].nil? &&
      headers['X-Auth-Nounce'].nil? &&
      headers['X-Auth-Signature'].nil?
      @apikey_headers = [headers['X-Auth-Apikey'], headers['X-Auth-Nounce'], headers['X-Auth-Signature']]
      validate_headers?
    end

    def validate_headers?
      @apikey_headers.each do |k|
        error!('Request contains invalid or blank api key headers!', 500) if k.blank?
      end
    end

    def apikey_params
      params = {}
      params.merge(
        'kid': headers['X-Auth-Apikey'],
        'nounce': headers['X-Auth-Nounce'],
        'signature':  headers['X-Auth-Signature']
      )
    end

    def error!(text, code)
      # raise an error
      response.status = code
      response.body = { 'error': text }.to_json
    end

    def headers
      @request.headers
    end

    def session
      @request.session
    end
  end
end

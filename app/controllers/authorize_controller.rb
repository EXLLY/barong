# frozen_string_literal: true

require_dependency 'barong/authorize'

# Rails Metal base controller to manage AuthZ story
class AuthorizeController < ActionController::Metal
  include AbstractController::Rendering

  def authorize
    req = Barong::Authorize.new(request, params[:path])

    return access_error!('permission_denied', 401) if req.restricted?('block')

    response.status = 200
    return if req.restricted?('pass')

    response.headers['Authorization'] = req.auth
  end

  private

  def session
    request.session
  end

  def access_error!(text, _code)
    response.status = code
    response.body = { 'error': text }.to_json
  end
end

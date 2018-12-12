Rails.application.routes.draw do
  mount API::Base, at: '/api'
  match '/api/v2/auth/*path', to: AuthorizeController.action(:authorize), via: [:get, :post, :delete, :head, :put, :patch]
end

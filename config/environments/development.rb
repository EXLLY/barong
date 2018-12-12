Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  ENV['EVENT_API_JWT_PRIVATE_KEY'] = 'LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcFFJQkFBS0NBUUVBMmxVUEJWVXkyeVdhNS85bmYyazN2SEZoNUY5Wjk5d2g3Q2FNU2dtK1A0cndsUERWCk9pZTZmdGsxY1FpM3R0bGdnOW10Z2J5UkNyZmNxZk1wTHF5TkE1aVZUZDlZTzdoU1crOXd2eG81RDFwVzRrc1oKeVZUc3plZDRmTGg5Z0ptSE0zd3BEdFkyZGZ3c3BidkRyM09TUEpFakxHVE5oR0ZDSmlTNDRTNmY1aytoSFFJMApoZkNHclNPVVI5N1ZwU0pNS2FDekdacmR4OUhsWDArYjhZdzFPcFNsa2IzblIvQituZWhPYzNXNm5QYTMyYzZiCnBZRi9mWmJ4SERNSmIzczZEYUxERzFTbmhqb0plVHo2SWg3Q2Qrc0NYWUl5Z2VHVE9sQ2dnNC9uZFRzSVN1dlAKS3ptdjFadDljWDhXV2VZQ3daRTFBOVpBOUZ3dC9nVXljZUpOMHdJREFRQUJBb0lCQUNxNXhJTzlwWU1mTzg0MAp1L05DQ3VjMHBQeUU4RjFCMWQyWnVaQnZrYXhycXlMcWNqKzhNSkhNUGRvTjQ2M0RvbENMRTVvMDVZbGNhN0ZTClpYZTl5cWF1Z0dGSjJNRnZFNmJzRjNzK1RYWkVyb1lBUGw2WTRQSjJYcXpCaWNYVnhaQjh0cWd4b1Z5N2FaMVIKUGowaWQ3YWtqR2FPbjIxTmZ4MXB5RWhBMElmSUp1eWMvQ2FpNk9iL1IvNkxXb1pDNXBjV2VzRlMyN3dkeHpNOQpGQm9YUnVWclE3c3hWNUl1WS9sc2EwQ1VTNUVLMWdxZDRobDRENXUrMG4wMElYQTk1QTE4QjhaNUhER0Y1T2QrCjN2MnJqTmVNaHNrZmdDZW5WN084NXhob1haeVYxSiswWGY1SDh3eFF6U1ZLa1BMVlVhSWJOdkMyMXhWRWkycWQKeHh6RVV4a0NnWUVBNzA0Z0VaNzNUUHIwbG1iZWVpTUJSRlhNZ2pKdWtlWWpKaFZvZWZwV1dydXhaRkxsR3E3WgpLdXlMcEQyMUc0akJLVThnZWc1N1lsaGQxUFBPS0dweUtsVHliYlo5TjU5TGFLSEw2Z3QyMUt1aFV3Q1Yya3cwCkw3RW5DbDgvRFBhRDhZa2llS0I1MjMyQVNZVEpVbHVrK09tbUdvSzM1NDE5T1FwV2M2QTJ6WVVDZ1lFQTZaQmUKQk9Od2NSYjJpc21GTWxZZ1gvU2ZtTTNVaSsvZFdaRW9lbTN6YkdxdkYvODFycm5UOUpVUndmYXZSYm9KaW9WQQpsMERLQW5zNSs4enJtbDdHQnNWN2JvUElqWWdUWGpRMGVMR0FzZjRwdlo5RWxpOS8yY05saUdIdElMMGYzQzVCCk90enpMcjRIdTB4amo3VVNWeCs5dXpFam4zdVpEMGI1M1RWeVFYY0NnWUVBbWdsVzJTRFRIS2taRVVyc0FBQlMKUzNOUzdhZWF4cTAxaU1rVTlCY3d5THl5UmRxYUFGLzJDQXcxSXFaWjBueG5vYmgrTmpMbU52cWNnM3ZnQXVIcAoxTmZUS00zanNnOEdValo3ZEk2bWtlUmNObnBVK3l3OEYwclh6M1JadUhWaG52TGZ6bmUxbUpRakpLK2xpeTdVCmRTaW9zNzNhdE9DOWJ4NzVZUG9LN0tVQ2dZRUEzeWRvTFJPQkl3dmxrc1RuMWlnajFvcEswaHdXcjMwRjU4V2cKL3hoK00xL2EydnFqdDhVa2xkSzNuTEtzMDluanM4Mk00UGF1QzZEZ3pZd0Vyd0ZPQXJvOExHTU5BdXk0VkpGYwpjTlJuT2FpMUNNOWJJSU5SakNYOHBFbXIzbFBVVlBKOHNGamFvQlpBSE52blpDNkV6MmtzUmVXMU8zTkQwaXptCkhrd3FWaEVDZ1lFQXFKbDdsVUlML1QzM0JyWmFTSmJ3WTdzaDh3bmlyeDcyYUw1TFI3RUVVNVFkQzNoT28vYlYKTTdtUnJCalB1ZGpmMXRHZ1pHWGxqSFR5cUJqQjJBMHphdXQvbXk5UEE2K1p1WEV3ektLb2xlRXUvemQ2Zm41NwpMNlp2VXE3bXZtK0tXbDNQeUFPemhKamE1aVp1Tmc0eGJDNGdQWVRkN1NGbUdUZm52UjJLbXpjPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=' 

  config.session_store :cookie_store,
                       key: '_barong_session',
                       domain: :all,
                       tld_length: 2
end

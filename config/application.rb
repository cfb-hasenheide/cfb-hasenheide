require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CfbHasenheide
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :de
    config.i18n.fallbacks = [:en]

    # Load models in subfolders
    config.autoload_paths += %W(#{config.root}/app/models/events)

    # Enable per-form CSRF tokens.
    config.action_controller.per_form_csrf_tokens = true

    # Enable origin-checking CSRF mitigation.
    config.action_controller.forgery_protection_origin_check = true

    # Make Ruby 2.4 preserve the timezone of the receiver when calling `to_time`.
    ActiveSupport.to_time_preserves_timezone = true

    # Require `belongs_to` associations by default.
    Rails.application.config.active_record.belongs_to_required_by_default = true

    # Do not halt callback chains when a callback returns false.
    ActiveSupport.halt_callback_chains_on_return_false = false
  end
end

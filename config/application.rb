require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CfbHasenheide
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

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

    # Do not suppress ActiveRecord errors raised within `after_rollback`/
    # `after_commit` callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    ActiveSupport.halt_callback_chains_on_return_false = false

    config.action_controller.per_form_csrf_tokens = true

    config.action_controller.forgery_protection_origin_check = true
  end
end

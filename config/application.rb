require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Littlefire
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
    end
    I18n.enforce_available_locales = false
    config.time_zone = 'Beijing'
    config.i18n.locale = "zh-CN"
    config.i18n.default_locale = "zh-CN"
    config.to_prepare do
        Devise::SessionsController.layout "devise"
        Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application"   : "devise" }
        Devise::ConfirmationsController.layout "devise"
        Devise::UnlocksController.layout "devise"            
        Devise::PasswordsController.layout "devise"        
    end
  end
end
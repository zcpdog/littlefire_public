require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Littlefire
  class Application < Rails::Application
    I18n.enforce_available_locales = false
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w(ckeditor/*)
    config.time_zone = 'Beijing'
    config.i18n.locale = "zh-CN"
    config.i18n.default_locale = "zh-CN"
    config.assets.initialize_on_precompile = false
    config.to_prepare do
        Devise::SessionsController.layout "devise"
        Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application"   : "devise" }
        Devise::ConfirmationsController.layout "devise"
        Devise::UnlocksController.layout "devise"            
        Devise::PasswordsController.layout "devise"        
    end
  end
end
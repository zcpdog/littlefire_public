require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Littlefire
  class Application < Rails::Application
    I18n.enforce_available_locales = false
    config.time_zone = 'Beijing'
    config.i18n.locale = "zh-CN"
    config.i18n.default_locale = "zh-CN"
  end
end

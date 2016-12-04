require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kuli
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    WECHAT_APP_ID = 'wx8035a1ddcde237dc'
    WECHAT_APP_SECRET = 'bf37388e9b00d6005e04ca832e87f9db'

    PAGE_SIZE = 10
    MAX_SHOWN_PAGES = 7
  end
end

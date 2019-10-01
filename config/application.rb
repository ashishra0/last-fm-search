require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.quiet = true
    config.session_store :cookie_store, key: Rails.application.credentials.secret_key_base
    # Rails.logger = Logger.new(STDOUT)
    # Rails.logger.level = Logger::DEBUG
    # Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"
  end
end

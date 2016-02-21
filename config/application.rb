require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'devise'
# require 'active_job'

Bundler.require(*Rails.groups)



module Octopus
  class Application < Rails::Application
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.initialize_on_precompile = false

    # Get the build number if there is one
    config.build_number = File.exists?(Rails.root.join('build_number')) ? File.read(Rails.root.join('build_number')) : '-'


    # Get the email_from_hostname if there is one
    config.email_from_hostname = ENV['EMAIL_FROM_HOSTNAME'] || 'ouroctopus.com'
    config.email_from_address = "Octopus <no-reply@#{config.email_from_hostname}>"
    config.google_analytics_id = ENV['GOOGLE_ANALYTICS_ID'] || "UA-XXXXXXX-XX"

    #omniauth
    config.facebook_pixel = ENV['FACEBOOK_PIXEL'] || "FBxxxxxxxxxxxxx"
    config.facebook_app_id = ENV['FACEBOOK_APP_ID'] || "FBappxxxxxxxxxxxxx"
    config.facebook_secret = ENV['FACEBOOK_SECRET'] || "FBsecretxxxxxxxxxxxxx"


    config.twitter_key = ENV['TWITTER_KEY'] || "TWxxxxxxxxxxxxx" 
    config.twitter_secret = ENV['TWITTER_SECRET'] || "TWxxxxxxxxSecret" 
    config.twitter_owner_id = ENV['TWITTER_OWNER_ID'] || "TWxxxxxxxxOwner"

    config.google_id = ENV['GOOGLE_CLIENT_ID'] || "GooClixxxxxxxxxxxxx" 
    config.google_secret = ENV['GOOGLE_CLIENT_SECRET'] || "GooSecxxxxxxxxSecret" 

     config.new_relic_license_key = ENV["NEW_RELIC_LICENSE_KEY"] || "newrlxxxxx"


    config.oct_env = ENV['OCT_ENV']
    config.rails_env = ENV['RAILS_ENV']
    config.is_production_environment = (config.rails_env=='production' && config.oct_env.blank?)
    # end
    config.is_development_environment =config.rails_env=='development'

    # Make sure to load things that we've placed in subfolders

    config.autoload_paths << "#{Rails.root}/app/models/roles"
    config.autoload_paths << "#{Rails.root}/app/models/projects"
    config.autoload_paths << "#{Rails.root}/app/models/participant_roles"
    config.autoload_paths << "#{Rails.root}/app/models/blog_posts"
    config.autoload_paths << "#{Rails.root}/app/models/email_kinds"

    config.exceptions_app = self.routes

  end
end

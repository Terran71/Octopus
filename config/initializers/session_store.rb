# Be sure to restart your server when you modify this file.

if Rails.env.production?
    Rails.application.config.session_store :cookie_store, key: '_octopus_session', domain: :all
else
    Rails.application.config.session_store :cookie_store, key: '_Heartbeat-pods_session'
end
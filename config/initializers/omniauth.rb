# Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?


 
 #    provider :facebook, Rails.application.config.facebook_app_id, Rails.application.config.facebook_secret
 #    provider :twitter, Rails.application.config.twitter_key, Rails.application.config.twitter_secret
 #    # provider :google_oauth2, Rails.application.config.google_client_id, Rails.application.config.google_client_secret, { :scope => "userinfo.email"}
 # provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], { :scope => "userinfo.email"}
# end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, Rails.application.config.twitter_key, Rails.application.config.twitter_secret
# end

# Rails.application.config.middleware.use OmniAuth::Builder do
#     # provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
#     provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], { :scope => "userinfo.email"}
# end

 # # provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
  # # provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  # provider :twitter, Rails.application.config.twitter_key, Rails.application.config.twitter_secret
  # provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], { :scope => "userinfo.email"}


Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?

    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], 
     {
      :name => "google_oauth2",
      :scope => "email, profile, plus.me",
      :prompt => "select_account",
      :image_aspect_ratio => "square",
      :image_size => 50
    }
end
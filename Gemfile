ruby '2.2.2'

source 'https://rubygems.org'

gem 'rails', '4.2.5.1'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks' 
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise', '~> 3.5', '>= 3.5.5'
gem 'omniauth', '~> 1.3', '>= 1.3.1'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2', '~> 0.3.0'
gem 'omniauth-twitter'
gem 'twitter' #for posting to twitter
gem 'koala' #for posting to facebook
gem 'sprockets-rails', '~> 3.0', '>= 3.0.1'

gem 'simple_form'
gem 'rails_admin'
gem 'rails_admin_import', '~> 1.0.0'
gem 'faker'
gem 'slim'
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'therubyracer'
gem 'twitter-bootstrap-rails', '~> 3.2', '>= 3.2.2'

# gem 'cancancan'
gem 'kaminari', '~> 0.16.3'
gem 'bootstrap-kaminari-views', '~> 0.0.5'
gem 'fog', require: 'fog/aws'
gem 'carrierwave'
gem 'rmagick', '~> 2.15.3'
gem 'simple_form_fancy_uploads', '~> 0.2.0'
gem 'holder_rails', '~> 2.8.0'
gem 'remotipart', '~> 1.2.1'
gem 'wysiwyg-rails', '~> 1.2.8'
gem 'meta-tags', '~> 2.1'
# gem 'speakingurl-rails'
gem 'acts_as_list', '~> 0.7.2'
gem 'factory_girl_rails'
gem 'friendly_id', '~> 5.1.0'

# gem 'addressable', '~> 2.3.8'
gem 'responders', '~> 2.1.0'
gem 'cocoon', '~> 1.2', '>= 1.2.7'
gem 'datetimepicker-rails', git: 'git://github.com/zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'momentjs-rails', '~> 2.9',  :github => 'derekprior/momentjs-rails'

gem 'sidekiq', '~> 3.5.0'

gem 'gon', '~> 6.0', '>= 6.0.1'

gem 'puma'
gem 'rack-timeout'

gem 'aws-sdk'

gem 'rest-client'




group :development do
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'foreman'
  gem 'guard-rspec', require: false
  gem 'mailcatcher', '~>0.6.1'
end


group :development, :test do
  gem 'rspec-rails'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'capybara-screenshot'
  gem 'db-query-matchers'
  gem 'timecop'
end

group :production do
  gem 'rails_12factor'
  gem 'redis'
  gem 'newrelic_rpm'
  gem 'airbrake'
end

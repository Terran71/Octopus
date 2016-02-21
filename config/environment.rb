# Load the Rails application.
require File.expand_path('../application', __FILE__)
env_vars = File.join(Rails.root, 'config',  'local_environment_variables.rb')

# Initialize the Rails application.
load(env_vars) if File.exists?(env_vars)

Rails.application.initialize!

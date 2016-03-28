    # require 'timezone'

Timezone::Lookup.config(:google) do |c|
  c.api_key =  ENV['TWITTER_CONSUMER_KEY'] 
  c.client_id =  ENV['GOOGLE_CLIENT_ID']  # if using 'Google for Work'
end
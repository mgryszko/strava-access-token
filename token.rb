require 'sinatra'
require 'oauth2'

get '/auth' do
  redirect client.auth_code.authorize_url({:redirect_uri => 'http://localhost:4567/onauth', :scope => :read})
end

get '/onauth' do
  access_token = client.auth_code.get_token(request.params['code'])
  access_token.token
end

def client
  OAuth2::Client.new(ENV['STRAVA_CLIENT_ID'], ENV['STRAVA_CLIENT_SECRET'], {
    :site => 'https://strava.com/',
    :authorize_url => 'https://www.strava.com/oauth/authorize',
    :token_url => 'https://www.strava.com/oauth/token'
  })
end

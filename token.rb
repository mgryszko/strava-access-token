#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'sinatra'
  gem 'oauth2'
end

require 'sinatra'
require 'oauth2'

port = 8080

set :port, port

get '/' do
  redirect client.auth_code.authorize_url({:redirect_uri => "http://localhost:#{port}/auth", :scope => :read})
end

get '/auth' do
  access_token = client.auth_code.get_token(request.params['code'])
  File.open('.access-token', 'w') { |file| file.write(access_token.token) }
  access_token.token
end

def client
  OAuth2::Client.new(ENV['STRAVA_CLIENT_ID'], ENV['STRAVA_CLIENT_SECRET'], {
    :site => 'https://strava.com/',
    :authorize_url => 'https://www.strava.com/oauth/authorize',
    :token_url => 'https://www.strava.com/oauth/token'
  })
end

puts "Open http://localhost:#{port}/ in browser"

Sinatra::Application.run!

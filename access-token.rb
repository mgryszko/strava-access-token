#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'sinatra'
  gem 'oauth2'
end

def print_usage
  command = File.basename($0)
  puts "Usage: #{command} <client_id> <client_secret>"
end

client_id, client_secret = ARGV
if client_id.to_s.strip.empty? || client_secret.to_s.strip.empty?
  print_usage
  exit(1)
end

require 'sinatra'
require 'oauth2'

port = 8080

set :port, port

get '/' do
  client = strava_oauth_client(client_id, client_secret)
  redirect client.auth_code.authorize_url({:redirect_uri => "http://localhost:#{port}/auth", :scope => 'read_all,profile:read_all,activity:read_all,activity:write'})
end

get '/auth' do
  client = strava_oauth_client(client_id, client_secret)
  access_token = client.auth_code.get_token(request.params['code'])
  File.open('.access-token', 'w') { |file| file.write(access_token.token) }
  access_token.token
end

def strava_oauth_client(client_id, client_secret)
  OAuth2::Client.new(client_id, client_secret, {
    :site => 'https://strava.com/',
    :authorize_url => 'https://www.strava.com/oauth/authorize',
    :token_url => 'https://www.strava.com/oauth/token'
  })
end

puts "Open http://localhost:#{port}/ in browser"

Sinatra::Application.run!

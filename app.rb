require 'sinatra'
require 'json'

get '/' do
  'Hello world!'
end

get '/api' do
  # Monkey patching
  # https://stackoverflow.com/a/3184039
  response = { 'payload': 'Hello world!' }
  response.to_json
end

require 'sinatra'
# Monkey patching
# https://stackoverflow.com/a/3184039
require 'json'
require 'pry' # only used for debugging
require './database/connection.rb'
require './api/v1/user_calories.rb'
require './api/v1/fallbacks.rb'

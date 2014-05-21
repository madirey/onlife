require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/player'
require './models/season'

get '/' do
  'This application is under development.'
end

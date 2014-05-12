require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models'

get '/' do
  'This application is under development.'
end

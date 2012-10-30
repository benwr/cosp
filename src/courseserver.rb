require 'sinatra/base'
require './timetable.rb'

class MyApp < Sinatra::Base
  get '/' do
    "To find info on, say, ENGE 1024, GET /ENGE/1024"
  end
end


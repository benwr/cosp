require 'sinatra'
require './timetable.rb'
require 'json'

get '/' do
  "To find info on, say, ENGE 1024, GET /ENGE/1024"
end

get '/search/:subj/:num' do
  t = Timetable.new
  JSON::dump(t.search('201301', params[:subj], params[:num], false))
end

get '/:subj/:num' do
  t = Timetable.new
  JSON::dump(t.course_info(params[:subj], params[:num]))
end

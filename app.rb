require 'sinatra'
require 'tilt/plain'

Tilt.register :html, Tilt[:erb]

helpers do
  def html(*args)
    render :html, *args
  end
end

get '/' do
  html :index
end

get '/resume' do
  send_file('public/pdf/resume.pdf', type: :pdf)
end

get '/game-of-life' do
  html :game_of_life
end

get '/julia' do
  html :julia
end

get '/music-visualizer' do
  html :'../public/projects/soundcloud-visualizer/html/index'
end

require 'sinatra'
require 'tilt/plain'

Tilt.register :html, Tilt[:erb]

set :views, ['views', 'public/projects']

helpers do
  def html(*args)
    render :html, *args
  end

  def find_template(views, name, engine, &block)
    views.each { |v| super(v, name, engine, &block) }
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
  html :'soundcloud-visualizer/html/index'
end

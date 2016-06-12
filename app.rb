require 'sinatra'
require 'sinatra/contrib'
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

namespace '/recreating-the-past' do
  get '/vera-molnar-molndrian' do
    html :'recreating-the-past/vera-molnar-molndrian'
  end
  get '/vera-molnar-molndrian-animated' do
    html :'recreating-the-past/vera-molnar-molndrian-animated'
  end
end

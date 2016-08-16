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

get '/work' do
  html :work
end

get '/sketches' do
  html :sketches
end

get '/about' do
  html :about
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

get '/blog/?*' do
  blog(request.path) { 404 }
end

namespace '/recreating-the-past' do
  get '/vera-molnar-molndrian' do
    html :'recreating-the-past/vera-molnar-molndrian'
  end
  get '/vera-molnar-molndrian-animated' do
    html :'recreating-the-past/vera-molnar-molndrian-animated'
  end
end

def blog(path, &missing_file_block)
  @title = 'orenshoham.com | blog'

  file_path = File.join(File.dirname(__FILE__), 'blog/_site', path.gsub('/blog', ''))
  unless file_path =~ /\.[a-z]+$/i
    if file_path == './blog/_site/'
      file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    else
      file_path = file_path + '.html'
    end
  end

  if File.exist?(file_path)
    file = File.open(file_path, 'rb')
    contents = file.read
    file.close

    html contents
  else
    html :not_found
  end
end

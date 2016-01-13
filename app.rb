require 'sinatra'

get '/' do
  erb :index
end

get '/resume' do
  send_file('public/pdf/resume.pdf', type: :pdf)
end

get '/game-of-life' do
  erb :game_of_life
end

get '/julia' do
  erb :julia
end

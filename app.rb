require 'sinatra'

get '/' do
  erb :index
end

get '/resume' do
  send_file('public/pdf/resume.pdf', type: :pdf)
end

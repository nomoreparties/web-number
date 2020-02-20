class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  # set public folder for static files
  set :public_folder, File.expand_path('../../public', __FILE__)

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  enable :sessions

  get '/' do
    erb :index
  end

  def secret_number
     session[:secret_number]
  end

  def tries
    session[:tries]
  end

  def guesses
    session[:guesses]
  end

  def diff
    params['diff']
  end

  def guess
    params['guess'].to_i
  end

  def first
    params['first']
  end

  post '/index.erb' do
    case diff
    when "easy"
      session[:secret_number] = rand(1..25) # Random Number from 1 to 25
    when "medium"
      session[:secret_number] = rand(1..50) # Random Number from 1 to 50
    when "hard"
      session[:secret_number] = rand(1..100) # Random Number from 1 to 100
    end
    session[:guesses] = Array.new
    session[:tries] = 6
    erb :play
  end

  post '/play.erb' do
    guesses << guess
    if guess == secret_number
      session[:tries] -= 1
      erb :win
    else
      session[:tries] -= 1
      puts session[:tries]
      if session[:tries].to_i == 0
        erb :fail
      else
        erb :play
      end
    end
  end
end

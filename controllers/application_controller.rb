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
    @secret_number
  end

  def diff
    params['diff']
  end

  def guess
    params['guess'].to_i
  end

  post '/index.erb' do
    case diff
    when "easy"
      secret_number = rand(1..25) # Random Number from 1 to 25
    when "medium"
      secret_number = rand(1..50) # Random Number from 1 to 50
    when "hard"
      secret_number = rand(1..100) # Random Number from 1 to 100
    end
    erb :play
  end

  post '/play.erb' do
    puts secret_number
    puts guess
    if guess < secret_number
      erb :toolow
    elsif guess > secret_number
      erb :toohigh
    elsif guess == secret_number
      erb :win
    end
  end
end

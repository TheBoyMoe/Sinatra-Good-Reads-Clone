require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    use Rack::Flash
    set :session_secret, "simple_reads_secret"

  end

  get '/' do
    if logged_in?
      redirect :"/users/#{current_user.slug}"
    else
      flash[:message] = "You need to logged in"
      redirect :'/login'
    end
  end

  # handle 404 errors
  not_found do
    flash[:message] = "Page not found"
    if logged_in?
      erb :'404'
    else
      redirect :'/login'
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def login(params)
      # check the the user has been registered and that we can authenticate them
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect :"/users/#{user.slug}"
      else
        flash[:message] = "Account not found, check spelling and try again"
        redirect :'/login'
      end
    end

    def logout
      session.clear
    end

    def path_info
      request.path_info
    end

  end


end

require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    register Sinatra::Flash

    set :session_secret, "simple_reads_secret"

    # helpers Sinatra::RedirectWithFlash

    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if logged_in?
      redirect :"/users/#{current_user.slug}"
    else
      redirect :'/login'
    end
  end


  # handle 404 errors
  not_found do
    if logged_in?
      erb :'404'
    else
      flash[:alert] = "You need to be logged in"
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
      user = User.find_by_slug(params[:username].downcase.gsub(' ', '-'))
      if !user
        flash[:alert] = "Account not found, check spelling and try again"
        redirect :'/login'
      else
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect :"/users/#{user.slug}"
        else
          flash[:alert] = "Username and password combination do not match, check spelling and try again"
          redirect :'/login'
        end
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

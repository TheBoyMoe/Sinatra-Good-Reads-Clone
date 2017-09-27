class UsersController < ApplicationController

  # users#new action
  get '/signup' do
    if logged_in?
      redirect :"/users/#{current_user.slug}"
    else
      erb :'/users/new'
    end
  end

  # users#create action - user registration
  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect :"/users/#{user.slug}"
    else
      flash[:message] = "Error registreing account, ensure all fields are complete and try again"
      redirect :'/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'/users/show'
    else
      not_found
    end
  end
end

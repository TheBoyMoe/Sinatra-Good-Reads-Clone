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
    if !user.save
      if !params[:username] || params[:username] == '' || !params[:email] || params[:email] == '' || params[:password] == ""
        flash[:message] = "Error registering account, ensure all fields are complete and try again"
      elsif User.find_by_slug(params[:username].downcase.gsub(' ', '-'))
        flash[:message] = "Error registering account, that username is in use. Try another"
      elsif User.find_by(email: params[:email])
        flash[:message] = "Error registering account, that email address is in use."
      end
      redirect :'/signup'
    else
      # new user created, redirect user to their home page
      session[:user_id] = user.id
      redirect :"/users/#{user.slug}"
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

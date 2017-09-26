class UsersController < ApplicationController

  # users#new action
  get '/signup' do
    if logged_in?
      redirect :'/home'
    else
      erb :'/users/new'
    end
  end

  # users#create action - user registration
  post '/signup' do
    user = User.new(params)
    # binding.pry
    if user.save
      session[:user_id] = user.id
      redirect :'/home'
    else
      flash[:message] = "Error registreing account, ensure all fields are complete and try again"
      redirect :'/signup'
    end
  end
end

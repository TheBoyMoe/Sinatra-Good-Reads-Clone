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
    binding.pry
  end
end

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
      # REVIEW:
      # This could be a helper method. present?(params[:username]) or if you import active_support core extensions you can use blank
      # http://guides.rubyonrails.org/active_support_core_extensions.html
      flash[:alert] = present?(params)
      redirect :'/signup'
    else
      # Maybe an opportunity for a factory method if this is something we want to do often
      # create default book shelves
      user.shelves << [
        Shelf.create(title: 'read'),
        Shelf.create(title: 'to-read'),
        Shelf.create(title: 'reading')
      ]

      # login & redirect user to the home page
      session[:user_id] = user.id
      redirect :"/"
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

  private
    def present?(params)
      if !params[:username] || params[:username] == '' || !params[:email] || params[:email] == '' || params[:password] == ""
        "Error registering account, ensure all fields are complete and try again"
      elsif User.find_by_slug(params[:username].downcase.gsub(' ', '-'))
        "Error registering account, that username is in use. Try another"
      elsif User.find_by(email: params[:email])
        "Error registering account, that email address is in use."
      end
    end
end

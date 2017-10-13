class ShelvesController < ApplicationController

  get '/shelves/:slug' do
    @user = User.find_by_slug(params[:slug])
    if !@user
      not_found
    else
      # REVIEW: 
      # This looks weird, let's talk about it
      # redirect user to home when trying to access another user's book shelf
      if @user.id != current_user.id
        redirect :'/'
      end
    end
    erb :'shelves/index'
  end
end

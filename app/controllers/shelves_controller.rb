class ShelvesController < ApplicationController

  get '/shelves/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'shelves/index'
  end
end

class ShelvesController < ApplicationController

  get '/shelves/:slug' do
    erb :'shelves/index'
  end
end

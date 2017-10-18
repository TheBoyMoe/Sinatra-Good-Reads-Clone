class ShelvesController < ApplicationController

  get '/shelves/:slug' do
    redirect_if_unauthorised && return

    @user = current_user
    erb :'shelves/index'
  end

  private

  def redirect_if_unauthorised
    if params[:slug] != current_user.slug
      redirect :'/'
      true
    else
      false
    end
  end

end

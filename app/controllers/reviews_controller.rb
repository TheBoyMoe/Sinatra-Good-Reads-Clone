class ReviewsController < ApplicationController

  # reviews#create action - create instance and save to the database
  post '/reviews/:user_slug/:title_slug' do
    # binding.pry
    user = User.find_by_slug(params[:user_slug])
    book = Book.find_by_title_slug(params[:title_slug])
    if params[:review] && params[:review] != ''
      review = Review.new(content: params[:review])
      review.user = user
      review.book = book
      review.save
      user.reviews << review
      book.reviews << review

      response.body = "#{params[:review]}"
    end
  end

  # reviews#edit action - display edit form


  # reviews#update action - update the instance



end

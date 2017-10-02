class BooksController < ApplicationController

  # books#create action
  post '/books' do
    binding.pry
    # {
    #   "goodreads_id"=>"248301630",
    #   "title"=>"The Illustrated Man",
    #   "author"=>"Ray Bradbury",
    #   "image_url"=>"https://images.gr-assets.com/books/1374049820m/24830.jpg",
    #   "publication_date"=>"1951",
    #   "average_rating"=>"4.13",
    #   "ratings_count"=>"58782",
    #   "reviews_count"=>"2691",
    #   "book_shelve"=> {
    #     "name"=>"reading"
    #   },
    #   "submit"=>"save"
    # }

  end

end

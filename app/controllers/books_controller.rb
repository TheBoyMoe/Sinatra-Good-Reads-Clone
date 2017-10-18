class BooksController < ApplicationController

  # book#create action
  post '/books' do

    # {
    #   "goodreads_id"=>"248301630",
    #   "title"=>"The Illustrated Man",
    #   "author"=>"Ray Bradbury",
    #   "image_url"=>"https://images.gr-assets.com/books/1374049820m/24830.jpg",
    #   "publication_date"=>"1951",
    #   "average_rating"=>"4.13",
    #   "ratings_count"=>"58782",
    #   "reviews_count"=>"2691",
    #   "book_shelve_name"=> "name"=>"reading",
    #   "submit"=>"save"
    # }

    book = Book.find_by(goodreads_id: params[:goodreads_id].to_i) || create_book(params)
    if book.nil?
      response.body = generate_response(params, 'Error saving book')
      return
    end

    if save_book_to_shelf(params[:book_shelf_name], book)
      response.body = generate_response(params, 'Book successfully saved')
    else
      response.body = generate_response(params, 'You have saved this book previously')
    end

  end

  # book#show action
  get '/books/:user_slug/:title_slug' do
    @user = User.find_by_slug(params[:user_slug])
    @book = Book.find_by_title_slug(params[:title_slug])

    if !@user || !@book
      not_found
    else
      if @user.id != current_user.id
        redirect :'/'
      else
        if @book && !@book.description
          @book = FetchBookDescription.new(@book.goodreads_id).save_description
        end
      end
    end

    erb :'/books/show'
  end

  private
    def save_book_to_shelf(shelf, book)
      # retrieve all the books in the users book shelf
      books_in_shelf = Shelf.find_by_slug(shelf, current_user.id).books
      # save the book if not found
      if books_in_shelf.include? book
        false
      else
        books_in_shelf << book
        true
      end
    end

    def generate_response(params, message)
      "#{params[:goodreads_id]}-#{message}"
    end

    def create_book(params)
      Book.create(
        goodreads_id: params[:goodreads_id],
        title: params[:title],
        author: params[:author],
        image_url: params[:image_url],
        year_published: params[:publication_date],
        ratings_average: params[:average_rating],
        ratings_count: params[:ratings_count],
        reviews_count: params[:reviews_count]
      )
    end

    def has_user_saved_book_before(params)
      all_my_books.find do |b|
        b.goodreads_id == params[:goodreads_id].to_i
      end
    end

    def all_my_books
      current_user.shelves.collect do |shelf|
        shelf.books
      end.flatten
    end

    def has_book_been_saved_before(params)
      Book.all.find do |b|
        b.goodreads_id == params[:goodreads_id].to_i
      end
    end

end

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

    # has the user saved the book in the past
    previous_book = current_user.shelves.find_by(title: 'all').books.find do |b|
      b.goodreads_id == params[:goodreads_id].to_i
    end

    # has the book been saved before
    book = Book.all.find do |b|
      b.goodreads_id == params[:goodreads_id].to_i
    end

    if !book
      # create book
      new_book = Book.new(
        goodreads_id: params[:goodreads_id],
        title: params[:title],
        author: params[:author],
        image_url: params[:image_url],
        year_published: params[:publication_date],
        ratings_average: params[:average_rating],
        ratings_count: params[:ratings_count],
        reviews_count: params[:reviews_count]
      )

      if new_book.save
        # add book to the current user's appropriate shelf
        save_book_to_shelf(params[:book_shelf_name], new_book)

        # send message back to user
        response.body = "#{params[:goodreads_id]}-Book successfully saved"
      else
        response.body = "#{params[:goodreads_id]}-Error saving book"
      end
    elsif book && !previous_book
      # book has been saved by another user, save it to the current user's book shelf
      save_book_to_shelf(params[:book_shelf_name], book)

      # send message back to user
      response.body = "#{params[:goodreads_id]}-Book successfully saved"
    elsif previous_book
      response.body = "#{params[:goodreads_id]}-You have saved this book previously"
    end

  end

  # book#show action
  get '/books/:title_slug' do
    # fetch book description and update the book
    goodreads_id = Book.find_by_title_slug(params[:title_slug]).goodreads_id
    if goodreads_id
      @book = FetchBookDescription.new(goodreads_id).save_description
    end

    erb :'/books/show'
  end

  private
    def save_book_to_shelf(shelf, book)
      case shelf
      when 'read'
        Shelf.find_by_slug('read', current_user.id).books << book
      when 'to-read'
        Shelf.find_by_slug('to-read', current_user.id).books << book
      when 'reading'
        Shelf.find_by_slug('reading', current_user.id).books << book
      end
      # add every book to 'all' book shelf
      Shelf.find_by_slug('all', current_user.id).books << book
    end

end

class SearchController < ApplicationController

  post '/search' do
    # find the book in the local database
    query = params[:query]
    if query.to_i > 0
      @book = Book.find_by(isbn13: query)
    else
      # try using title and author slugs
      @book = Book.find_by_title_slug(query.downcase.gsub(/[,()#{}:]/, '').gsub(' ', '-'))
      if !@book
        @book = Book.find_by_author_slug(query.downcase.gsub(' ', '-'))
      end
    end

    # otherwise search online

    # render
    if @book
      erb :'/books/show'
    else
      not_found
    end
  end
end

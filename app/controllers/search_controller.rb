class SearchController < ApplicationController

  post '/results' do
    # find the book in the local database
    query = params[:query]
    # search on ISBN
    @book = Book.find_by_isbn_slug(query.gsub(/ -/,''))
    if !@book
      # search on title
      @book = Book.find_by_title_slug(query.downcase.gsub(/[,()#{}:]/, '').gsub(' ', '-'))
      if !@book
        # search on author
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

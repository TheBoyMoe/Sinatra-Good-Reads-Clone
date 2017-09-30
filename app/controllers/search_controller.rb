class SearchController < ApplicationController

  post '/results' do
    # find the book in the local database
    query = params[:query]
    @book = find_by_isbn(query)
    if !@book
      @book = find_by_title(query)
      if !@book
        # search on author
        @book = find_by_author(query)
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


  def find_by_isbn(query)
    Book.find_by_isbn_slug(query.gsub(/ -/,''))
  end

  def find_by_title(query)
    Book.find_by_title_slug(query.downcase.gsub(/[,()#{}:]/, '').gsub(' ', '-'))
  end

  def find_by_author(query)
    Book.find_by_author_slug(query.downcase.gsub(' ', '-'))
  end


end

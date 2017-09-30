class SearchController < ApplicationController

  post '/results' do
    # find the book in the local database
    query = params[:query]
    @book = find_by_isbn(query)
    if !@book
      @book = find_by_title(query)
      if !@book
        @book = find_by_author(query)
        # otherwise search goodreads
        if !@book
          puts find_by_api(query)
        end
      end
    end

    # render
    if @book
      erb :'/books/show'
    elsif @data
      erb :'/books/index'
    else
      not_found
    end
  end

  private
    def find_by_isbn(query)
      Book.find_by_isbn_slug(query.gsub(/ -/,''))
    end

    def find_by_title(query)
      Book.find_by_title_slug(query.downcase.gsub(/[,()#{}:]/, '').gsub(' ', '-'))
    end

    def find_by_author(query)
      Book.find_by_author_slug(query.downcase.gsub(' ', '-'))
    end

    def find_by_api(query)
      # Book.create(title: 'The Martian Chronicles', author: 'Ray Bradbury', rating: 4.12)
      feed = FetchBookData.new(query)
      feed.fetch_data
    end
end

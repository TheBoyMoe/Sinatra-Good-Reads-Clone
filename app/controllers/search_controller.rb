class SearchController < ApplicationController

  post '/results' do
    # find the book in the local database
    query = params[:query]

    @book = find_by_title(query)
    if !@book
      @book = find_by_author(query)
      # otherwise search goodreads
      if !@book
        @data = find_by_api(query)
      end
    end


    # TODO render
    if @book
      erb :'/books/show'
    elsif @data
      erb :'/books/index'
    else
      not_found
    end
  end

  private

    def find_by_title(query)
      Book.find_by_title_slug(query.downcase.gsub(/[,()#{}:]/, '').gsub(' ', '-'))
    end

    def find_by_author(query)
      Book.find_by_author_slug(query.downcase.gsub(' ', '-'))
    end

    def find_by_api(query)
      FetchBookData.new(query).parse_xml
    end
end

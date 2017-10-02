require 'spec_helper'

describe 'BookController' do

  context '/books' do
    it "saves the book to the databse" do
      params = {
        goodreads_id: 123456,
        title: 'The Martian Chronicles',
        author: 'Ray Bradbury',
        image_url: 'http://path/no_image.jpg',
        publication_date: '1952',
        average_rating: '4.19',
        ratings_count: '123456',
        reviews_count: '654123',
        book_shelve: {
          name: 'to_read'
        }
      }
      post '/books', params

      # write expectations


    end
  end

end

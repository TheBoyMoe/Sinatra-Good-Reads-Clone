require 'spec_helper'

describe 'BookController' do
  before do
    Book.destroy_all
  end

  context '/books' do
    params = {
      goodreads_id: 123456,
      title: 'The Martian Chronicles',
      author: 'Ray Bradbury',
      image_url: 'http://path/no_image.jpg',
      publication_date: 1952,
      average_rating: 4.19,
      ratings_count: 123456,
      reviews_count: 654123,
      book_shelf: {
        name: 'to_read'
      }
    }

    it "saves the book to the databse" do
      post '/books', params

      expect(Book.all.size).to eq(1)
      expect(Book.find(1).goodreads_id).to eq(params[:goodreads_id])
      expect(Book.find(1).title).to eq(params[:title])
      expect(Book.find(1).author).to eq(params[:author])
      expect(Book.find(1).image_url).to eq(params[:image_url])
      expect(Book.find(1).year_published).to eq(params[:publication_date])
      expect(Book.find(1).ratings_average).to eq(params[:average_rating])
      expect(Book.find(1).ratings_count).to eq(params[:ratings_count])
      expect(Book.find(1).book_shelf_name).to eq(params[:book_shelf_name])
      expect(Book.find(1).reviews_count).to eq(params[:reviews_count])
    end

    it "does not save books already in the databse" do
      Book.create(title: 'The Martian Chronicles', author: 'Ray Bradbury', goodreads_id: 123456)
      post '/books', params

      expect(Book.all.size).to eq(1)
    end
  end

end

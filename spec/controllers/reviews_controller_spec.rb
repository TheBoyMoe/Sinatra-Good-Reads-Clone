require 'spec_helper'

describe 'ReviewsController' do
  before do
    Book.destroy_all
    Shelf.destroy_all
    User.destroy_all

    @user = User.new(username: 'test user', email: 'test@example.com', password: 'test1234')
    @user.shelves << [
      Shelf.create(title: 'read'),
      Shelf.create(title: 'to-read'),
      Shelf.create(title: 'reading')
    ]
    @user.save
    @book = Book.create(goodreads_id: 76778, title: 'The Martian Chronicles', author: 'Ray Bradbury')
    @user.shelves.find_by(title: 'read').books << @book

    get '/login', {}, {'rack.session' => {user_id: @user.id}}
    visit "/books/#{@book.title_slug}"
  end

  describe "get /reviews" do
    it "shows a 'add' review button if the user has not added a review" do
      find_button('Add review').click
    end
  end

  xdescribe "post /reviews" do

  end

  describe "get /reviews/:id/edit" do
    it "shows a 'edit' review button if the user has added a review" do
      find_button('Edit review').click
    end
  end

  xdescribe "post /reviews/:id/edit" do

  end

end

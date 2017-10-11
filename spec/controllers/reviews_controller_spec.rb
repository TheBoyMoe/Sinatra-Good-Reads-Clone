require 'spec_helper'

describe 'ReviewsController' do
  before :each do
    @user = User.create(username: 'tom', email: 'tom@example.com', password: 'pass')
    get '/login', {}, {'rack.session' => {user_id: @user.id}}
    @book = Book.create(goodreads_id: 24083, title: 'The Illustrated Man', author: 'Ray Bradbury', description: "That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")
  end

  # test review#create action
  describe "post /reviews/:user_slug/:title_slug/" do
    it "allows the user to add a review to the book being viewd" do
      visit "/books/#{@user.slug}/#{@book.title_slug}"
      fill_in(:review, with: 'Loved the book, better than the first. 5 stars!', visible: false)
      find_button('Add review', visible: false).click

      expect(Review.all.size).to eq(1)
      expect(Review.find(1).content).to eq('Loved the book, better than the first. 5 stars!')
    end
  end

  # TODO: update the review
  # test review#update action
  xdescribe "patch /reviews/:id/edit" do
    it "updates the review" do

    end
  end

end

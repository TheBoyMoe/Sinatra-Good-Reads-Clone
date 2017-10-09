require 'spec_helper'

describe 'ReviewsController' do

  xdescribe "post /reviews" do
    it "allows the user to add a review, if they have not done so" do
      click_link "Add review"
      # TODO
    end

  end

  xdescribe "get /reviews/:id/edit" do
    before do
      @review = Review.new(content: 'Loved the book')
      @review.book = @book
      @review.user = @user
      @review.save
      @book.reviews << review
      @user.reviews << review
    end

    it "allows the user to edit the review if the user added one" do
      click_link ('Edit review')
      follow_redirect!

      expect(last_response.location).to eq("/reviews/#{@review.id}/edit")
    end
  end

  xdescribe "post /reviews/:id/edit" do
    it "updates the review" do

    end
  end

end

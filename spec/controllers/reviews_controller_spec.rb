require 'spec_helper'

describe 'ReviewsController' do
  before :each do
    @user = User.create(username: 'tom', email: 'tom@example.com', password: 'pass')
    @book = Book.create(goodreads_id: 24083, title: 'The Illustrated Man', author: 'Ray Bradbury', description: "That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")

    visit '/login'
    fill_in "username", with: "tom"
    fill_in "password", with: "pass"
    click_button "Login"
  end

  # test review#create action
  describe "post /reviews/:user_slug/:title_slug/" do
    it "allows the user to add a review to the book being viewed" do
      visit "/books/#{@user.slug}/#{@book.title_slug}"
      fill_in 'review', with: 'Loved the book, better than the first. 5 stars!', visible: false
      find_button('Add review', visible: false).click

      expect(Review.all.size).to eq(1)
      expect(Review.find(1).content).to eq('Loved the book, better than the first. 5 stars!')
    end
  end

  # test review#update action
  describe "patch /reviews/:id/edit" do
    before :each do
      @review = Review.new(content: 'Really enjoyed the book, better than the last. 5 stars!')
      @review.user = @user
      @review.book = @book
      @review.save
      @book.reviews << @review
      @user.reviews << @review
    end

    it "updates the review" do
      visit "/books/#{@user.slug}/#{@book.title_slug}"
      click_link('edit review').click
      fill_in 'edit', with: "Didn't like the book at all. Gave it only 2 stars"
      find_button('Update review').click

      expect(Review.find(@review.id).content).to eq("Didn't like the book at all. Gave it only 2 stars")
    end
  end

end

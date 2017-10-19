require 'spec_helper'

describe 'Book view' do
  before :each do
    @user = User.create(username: 'user', email: 'user@example.com', password: 'pass')
    @book = Book.create(goodreads_id: 24083, title: 'The Illustrated Man', author: 'Ray Bradbury', description: "That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")

    @user.shelves << [
      Shelf.create(title: 'read'),
      Shelf.create(title: 'to-read'),
      Shelf.create(title: 'reading')
    ]
    @user.save
    @user.shelves.find_by(title: 'read').books << @book

    visit '/login'
    fill_in "username", with: @user.username
    fill_in "password", with: @user.password
    click_button "Login"
  end

  it "displays the book details" do
    visit "/books/#{@user.slug}/#{@book.title_slug}"

    expect(page.body).to include('The Illustrated Man')
    expect(page.body).to include('Ray Bradbury')
    expect(page.body).to include("That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")
  end

  it "displays other users reviews for the same book" do
    user1 = User.create(username: 'Dick', email: 'dick@ex.com', password: '1234')
    review1 = Review.new(content: 'Leverage agile frameworks to provide a robust synopsis for high level overviews.')
    review1.user = user1
    review1.book = @book
    review1.save
    user1.reviews << review1

    user2 = User.create(username: 'Harry', email: 'Harry@ex.com', password: '5678')
    review2 = Review.new(content: "Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.")
    review2.user = user2
    review2.book = @book
    review2.save
    user2.reviews << review2

    @book.reviews << [review1, review2]

    visit "/books/#{@user.slug}/#{@book.title_slug}"

    expect(page.body).to include('Dick')
    expect(page.body).to include('Leverage agile frameworks to provide a robust synopsis for high level overviews.')
    expect(page.body).to include('Harry')
    expect(page.body).to include("Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.")
  end

  context 'Allow a user to add a review' do
    it "displays a form allowing the user to add a review if they have not already" do
      visit "/books/#{@user.slug}/#{@book.title_slug}"
      
      # confirm hidden elements are present
      page.has_css?('form#review-form', visible: false)
      page.has_css?('.field.submit .button[type="submit"]', visible: false)
    end

    it "updates page, displaying the submitted review, and 'Edit review' link, after a review is submitted" do
      visit "/books/#{@user.slug}/#{@book.title_slug}"
      find('.title', text: 'Add a review').click
      fill_in 'review', with: 'Loved the book, better than the first. 5 stars!', visible:false
      find_button('Add review', visible: false).click

      expect(page.body).to include('Loved the book, better than the first. 5 stars!')
      # find_link('edit review').visible?
    end
  end

  xcontext 'Edit Review' do
    before :each do
      @review = Review.new(content: 'Really enjoyed the book, better than the last. 5 stars!')
      @review.user = @user
      @review.book = @book
      @review.save
      @book.reviews << @review
      @user.reviews << @review
    end

    it "displays a review and an 'Edit review' link if the user added a review in the past" do
      visit "/books/#{@user.slug}/#{@book.title_slug}"

      expect(page.body).to include('Really enjoyed the book, better than the last. 5 stars!')
      find_link('edit review').visible?
    end

    it "displays a modal with a textarea allowing the user to edit their review contents when the user clicks on the 'edit review' link" do
      visit("/books/#{@user.slug}/#{@book.title_slug}")
      click_link('edit review').click

      expect(page).to have_selector('form')
      expect(page).to have_selector('textarea')
      expect(page.body).to include("Really enjoyed the book, better than the last. 5 stars!")
      find_button('Update review')
    end

    it "displays the updated review once the edited review has been saved and 'edit review' link" do
      visit "/books/#{@user.slug}/#{@book.title_slug}"
      click_link('edit review').click
      fill_in(:edit, with: "Didn't like the book at all. Gave it only 2 stars")
      find_button('Update review').click
      follow_redirect!

      find_link('edit review').visible?
      expect(page.body).to include("Didn't like the book at all. Gave it only 2 stars")
    end

  end

end

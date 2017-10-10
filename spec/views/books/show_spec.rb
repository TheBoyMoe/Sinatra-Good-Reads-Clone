require 'spec_helper'

describe 'Book view' do
  before :each do
    @user = User.create(username: 'tom', email: 'tom@example.com', password: 'pass')
    get '/login', {}, {'rack.session' => {user_id: @user.id}}
    @book = Book.create(goodreads_id: 24083, title: 'The Illustrated Man', author: 'Ray Bradbury', description: "That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")
  end

  it "displays the book details" do
    visit "/books/#{@user.slug}/#{@book.title_slug}"

    expect(page.current_path).to eq("/books/tom/the-illustrated-man")
    expect(page.body).to include('The Illustrated Man')
    expect(page.body).to include('Ray Bradbury')
    expect(page.body).to include("That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")
  end

  it "displays a form allowing the user to add a review if they have not already" do
    visit "/books/#{@user.slug}/#{@book.title_slug}"

    expect(page).to have_field(:review)
    find_button('Add review')
  end

  # TODO: test a returning ajax call
  it "updates page, displaying the submitted review, and 'Edit review' link, after a review is submitted" do
    visit "/books/#{@user.slug}/#{@book.title_slug}"
    fill_in(:review, with: 'Loved the book, better than the first. 5 stars!')
    find_button('Add review').click

    # check review displayed
    expect(page.body).to include('Loved the book, better than the first. 5 stars!')
    # find_link('Edit review').visible?
  end

  it "displays a review and an 'Edit review' link if the user added a review in the past" do
    review = Review.create(content: 'Really enjoyed the book, better than the last. 5 stars!')
    review.user = @user
    review.book = @book
    review.save
    @book.reviews << review
    @user.reviews << review
    visit "/books/#{@user.slug}/#{@book.title_slug}"

    expect(page.body).to include('Really enjoyed the book, better than the last. 5 stars!')
    find_link('edit review').visible?
  end

  it "displays an edit form modal if the user clicks on the 'Edit review' link" do
    # TODO: click on edit link

    # check that the review is displayed for editing
  end

  it "displays the updated review once the edited review has been saved" do
    # TODO:
  end

  it "displays other users reviews for the same book" do
    user1 = User.create(username: 'dick')
    review1 = Review.new(content: 'Leverage agile frameworks to provide a robust synopsis for high level overviews.')
    review1.user = user1
    review1.book = @book
    review1.save
    user1.reviews << review1

    user2 = User.create(username: 'harry')
    review2 = Review.new(content: "Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.")
    review2.user = user2
    review2.book = @book
    review2.save
    user2.reviews << review2

    @book.reviews << [review1, review2]

    visit "/books/#{@user.slug}/#{@book.title_slug}"
    save_and_open_page

    expect(page.body).to include('Dick')
    expect(page.body).to include('Leverage agile frameworks to provide a robust synopsis for high level overviews.')
    expect(page.body).to include('Harry')
    expect(page.body).to include("Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.")
  end


end

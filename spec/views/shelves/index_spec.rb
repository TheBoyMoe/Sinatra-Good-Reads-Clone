require 'spec_helper'

describe 'Shelf view' do

  before do
    Book.destroy_all
    Shelf.destroy_all
    User.destroy_all

    # create user, shelves and log them in
    @user = User.new(username: 'tom', email: 'test@example.com', password: 'pass')
    @user.shelves << [
      Shelf.create(title: 'read'),
      Shelf.create(title: 'to-read'),
      Shelf.create(title: 'reading')
    ]
    @user.save

    book1 = Book.create(goodreads_id: 76778, title: 'The Martian Chronicles', author: 'Ray Bradbury')
    book2 = Book.create(goodreads_id: 24830, title: 'The Illustrated Man', author: 'Ray Bradbury')
    book3 = Book.create(goodreads_id: 29579, title: 'Foundation', author: 'Isaac Asimov')

    @user.shelves.find_by(title: 'read').books << book1
    @user.shelves.find_by(title: 'to-read').books << book2
    @user.shelves.find_by(title: 'reading').books << book3

    visit '/login'
    fill_in "username", with: "tom"
    fill_in "password", with: "pass"
    click_button "Login"
  end

  context "when the user logs in and clicks on the 'myBooks' link" do

    it "displays 'all' the user's books by default" do
      visit "/shelves/#{@user.slug}"

      page.has_text?('The Martian Chronicles', {exact: true})
      page.has_text?('The Illustrated Man', {exact: true})
      page.has_text?('Foundation', {exact: true})
    end

    it "displays the books in the 'read' shelf when clicking on the 'read' link" do
      visit "/shelves/#{@user.slug}"
      find('#read-link').click
      binding.pry
      page.has_css?('.read-tab.active') # visible tab
      page.has_css?('.all-tab.active')
      page.has_css?('.reading-tab.active')
      page.has_css?('.to-read-tab.active')
    end

    it "displays the books in the 'to-read' shelf when clicking on the 'to read' link" do
      visit "/shelves/#{@user.slug}"
      find('#to-read-link').click
      # TODO

    end

    it "displays the books in the 'reading' shelf when clicking on the 'reading' link" do
      visit "/shelves/#{@user.slug}"
      find('#reading-link').click
      # TODO

    end

    it "displays all the books when the user clicks on the 'all' link" do
      get "/shelves/#{@user.slug}"
      find('#all-link').click
      # TODO
    end

  end

  # TODO finds two links on page
  xcontext "click on book title link" do

    it "redirects user to the book show page displaying book details, including description" do
      get "/shelves/#{@user.slug}"
      # save_and_open_page
      click_link "The Illustrated Man"
      follow_redirect!

      expect(page.current_path).to eq("/books/the-illustrated-man")
      expect(page.body).to include('The Illustrated Man')
      expect(page.body).to include('Ray Bradbury')
      page.has_text? "That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work."
    end

  end

end

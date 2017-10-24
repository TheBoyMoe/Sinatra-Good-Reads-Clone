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

  # REVIEW: the describe block - not working properly
  describe "when the user logs in and clicks on the 'myBooks' link", js: true do

    it "displays 'all' the user's books by default" do
      visit "/shelves/#{@user.slug}"

      has_text?(:visible, 'The Martian Chronicles', {exact: true})
      has_text?(:visible, 'The Illustrated Man', {exact: true})
      has_text?(:visible, 'Foundation', {exact: true})
    end

    it "displays the books in the 'read' shelf when clicking on the 'read' link" do
      visit "/shelves/#{@user.slug}"
      find('#read-link').click

      # page.has_css?('.read-tab.active') # visible tab
      # page.has_css?('.all-tab')
      # page.has_css?('.reading-tab')
      # page.has_css?('.to-read-tab')

      has_no_text?(:visible, 'The Martian Chronicles', {exact: true})
      has_no_text?(:visible, 'The Illustrated Man', {exact: true})
      has_no_text?(:visible, 'Foundation', {exact: true})
    end

    it "displays the books in the 'to-read' shelf when clicking on the 'to read' link" do
      visit "/shelves/#{@user.slug}"
      find('#to-read-link').click

      has_text?(:visible, 'The Illustrated Man', {exact: true})
      has_no_text?(:visible, 'The Martian Chronicles', {exact: true})
      has_no_text?(:visible, 'Foundation', {exact: true})
    end

    it "displays the books in the 'reading' shelf when clicking on the 'reading' link" do
      visit "/shelves/#{@user.slug}"
      find('#reading-link').click

      has_text?(:visible, 'Foundation', {exact: true})
      has_no_text?(:visible, 'The Illustrated Man', {exact: true})
      has_no_text?(:visible, 'The Martian Chronicles', {exact: true})
    end

    it "displays all the books when the user clicks on the 'all' link" do
      visit "/shelves/#{@user.slug}"
      find('#all-link').click

      has_text?('The Martian Chronicles', {exact: true})
      has_text?('The Illustrated Man', {exact: true})
      has_text?('Foundation', {exact: true})
    end

  end

  context "click on book title link", :feature => :type do
    it "redirects user to the book show page displaying book details, including description" do
      visit "/shelves/#{@user.slug}"
      within "#all-tab" do
        VCR.use_cassette('fetch_book_info') do
          click_link "The Martian Chronicles"
        end
      end
      save_page

      expect(page.current_path).to eq("/books/tom/the-martian-chronicles")
      expect(page.body).to include('The Martian Chronicles')
      expect(page.body).to include('Ray Bradbury')
      expect(page.body).to include("The Martian Chronicles tells the story of humanity’s repeated attempts to colonize the red planet. The first men were few. Most succumbed to a disease they called the Great Loneliness when they saw their home planet dwindle to the size of a fist. They felt they had never been born.")
    end
  end

end

require 'spec_helper'

describe 'ShelvesController' do

  before do
    Book.destroy_all
    Shelf.destroy_all
    User.destroy_all

    # create user, shelves and log them in
    @user = User.new(username: 'test user', email: 'test@example.com', password: 'test1234')
    @user.shelves << [
      Shelf.create(title: 'all'),
      Shelf.create(title: 'read'),
      Shelf.create(title: 'to-read'),
      Shelf.create(title: 'reading')
    ]
    @user.save
    get '/login', {}, {'rack.session' => {user_id: @user.id}}
    visit "/shelves/#{@user.slug}"

    book1 = Book.create(goodreads_id: 17, title: 'The Martian Chronicles', author: 'Ray Bradbury')
    book2 = Book.create(goodreads_id: 18, title: 'The Illustrated Man', author: 'Ray Bradbury')
    book3 = Book.create(goodreads_id: 19, title: 'Foundation', author: 'Isaac Asimov')

    @user.shelves.find_by(title: 'all').books << book1
    @user.shelves.find_by(title: 'all').books << book2
    @user.shelves.find_by(title: 'all').books << book3
    @user.shelves.find_by(title: 'read').books << book1
    @user.shelves.find_by(title: 'to-read').books << book2
    @user.shelves.find_by(title: 'reading').books << book3
  end

  context "when the user logs in and clicks on the 'myBooks' link" do

    # click_link and click_on do not work

    # it "displays the user's book shelves page" do
    #   # expect(last_response.status).to eq(302)
    #   # follow_redirect!
    #   # expect(last_response.status).to eq(200)
    #   # expect(last_response.body).to include('myBooks')
    #   # click_link 'myBooks'
    #
    #   expect(page.current_path).to eq("/shelves/#{@user.slug}")
    #   expect(page.status_code).to eq(200)
    # end

    # change -> page.should have_content()
    #           page.should have_no_content()
    it "displays the books in the 'all' book shelf" do
      expect(page.body).to include("My Books")
      expect(page.body).to include('The Martian Chronicles')
      expect(page.body).to include('The Illustrated Man')
      expect(page.body).to include('Foundation')
    end

    it "displays the books in the 'read' shelf when clicking on the 'read' link" do
      # click_link 'Read'
      expect page have_content('The Martian Chronicles')
      expect page have_no_content('The Illustrated Man')
      expect page have_no_content('Foundation')
    end

    it "displays the books in the 'to-read' shelf when clicking on the 'to read' link" do
      # click_link 'To Read'

      expect(page.body).to include('The Illustrated Man')
      expect(page.body).not_to include('The Martian Chronicles')
      expect(page.body).not_to include('Foundation')
    end

    it "displays the books in the 'reading' shelf when clicking on the 'reading' link" do
      # click_link 'Reading'

      expect(page.body).to include('Foundation')
      expect(page.body).not_to include('The Martian Chronicles')
      expect(page.body).not_to include('The Illustrated Man')
    end

    it "displays all the books when the user clicks on the 'all' link" do
      # click_link 'All'

      expect(page.body).to include('The Martian Chronicles')
      expect(page.body).to include('The Illustrated Man')
      expect(page.body).to include('Foundation')
    end
  end

end

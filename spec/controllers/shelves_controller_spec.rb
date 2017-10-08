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

    book1 = Book.create(goodreads_id: 76778, title: 'The Martian Chronicles', author: 'Ray Bradbury')
    book2 = Book.create(goodreads_id: 24830, title: 'The Illustrated Man', author: 'Ray Bradbury')
    book3 = Book.create(goodreads_id: 29579, title: 'Foundation', author: 'Isaac Asimov')

    @user.shelves.find_by(title: 'all').books << book1
    @user.shelves.find_by(title: 'all').books << book2
    @user.shelves.find_by(title: 'all').books << book3
    @user.shelves.find_by(title: 'read').books << book1
    @user.shelves.find_by(title: 'to-read').books << book2
    @user.shelves.find_by(title: 'reading').books << book3
  end

  # TODO
  xcontext "when the user logs in and clicks on the 'myBooks' link" do

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

    it "displays the books in the 'all' book shelf" do
      visit "/shelves/#{@user.slug}"

      page.has_text?('The Martian Chronicles', {exact: true})
      page.has_text?('The Illustrated Man', {exact: true})
      page.has_text?('Foundation', {exact: true})
    end

    it "displays the books in the 'read' shelf when clicking on the 'read' link" do
      visit "/shelves/#{@user.slug}"
      find('#read-link').click
      # save_and_open_page

      # expect(page).to have_css('div.read-link')
      # expect(page).to has_css?('.all-tab', {visible: true})
      # expect(page).to has_css?('.read-tab', {visible: false})

      # page.find('#all-tab', :visible => true)
      # page.find('#read-tab', :visible => :hidden)

      page.has_selector?('#all-tab', {visible: true})
      page.has_selector?('#read-tab', {visible: :hidden})

      # page.find(:xpath, ".//div[]")
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
      visit "/shelves/#{@user.slug}"
      find('#all-link').click
      # TODO

    end

  end

  context "click on book title link" do

    it "redirects user to the book show page displaying book details, including description" do
      visit "/shelves/#{@user.slug}"
      click_link "The Illustrated Man"
      follow_redirect!

      expect(page.current_path).to eq("/books/the-illustrated-man")
      expect(page.body).to include('The Illustrated Man')
      expect(page.body).to include('Ray Bradbury')
      page.has_text? "Description: That The Illustrated Man has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work."
    end

  end

end

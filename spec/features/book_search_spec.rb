require 'spec_helper'

describe 'Book search' do

  before do
    User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
    visit '/login'
    fill_in "username", with: "test user"
    fill_in "password", with: "test1234"
    click_button "Login"
  end

  context "Page" do
    it "displays a search field" do
      expect(page.current_path).to eq('/')
      expect(page).to have_selector('form')
      expect(page).to have_field(:query)
    end
  end

  context "uses the goodreads api" do

    it "looks for the book based on the author" do
      VCR.use_cassette('book-search-on-author') do
        fill_in 'query', with: 'Ray Bradbury'
        click_button "Go"
      end

      expect(page.current_path).to eq('/results')
      expect(page.body).to include("The Martian Chronicles")
      expect(page.body).to include("Ray Bradbury")
    end

    it "looks for the book based on the title" do
      VCR.use_cassette('book-search-on-title') do
        fill_in 'query', with: 'The Martian Chronicles'
        click_button "Go"
      end

      expect(page.current_path).to eq('/results')
      expect(page.body).to include("The Martian Chronicles")
      expect(page.body).to include("Ray Bradbury")
    end
  end
end

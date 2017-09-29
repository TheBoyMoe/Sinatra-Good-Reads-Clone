require 'spec_helper'

describe 'Book search' do

  before do
    Book.create(title: "2001, A Space Odyssey", author: 'Arthur C Clarke', isbn13: '123456789')
    User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
    visit '/login'
    fill_in "username", with: "test user"
    fill_in "password", with: "test1234"
    click_button "Login"
  end

  context "in the local database" do

    it "displays a search field" do
      expect(page.current_path).to eq('/users/test-user')
      expect(page).to have_selector('form')
      expect(page).to have_field(:query)
    end

    it "looks for the book based on it's ISBN number" do
      fill_in 'query', with: '123456789'
      click_button "Go"

      expect(page.current_path).to eq('/search')
      expect(page.body).to include("2001, A Space Odyssey")
      expect(page.body).to include('Arthur C Clarke')
    end

    it "looks for the book based on the title" do

    end

    it "looks for the book based on the author" do

    end
  end

  context "uses the goodreads api" do
    it "looks for the book based on it's ISBN number" do

    end

    it "looks for the book based on the author" do

    end

    it "looks for the book based on the title" do

    end
  end
end

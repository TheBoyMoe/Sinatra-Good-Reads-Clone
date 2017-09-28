require 'spec_helper'

describe 'Book search' do

  context "in the local database" do
    book = Book.create(title: "2001, A Space Odyssey", author: 'Arthur C Clarke', isbn13: '123456789')

    it "displays a search field" do
      User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
      visit '/login'
      fill_in "username", with: "test user"
      fill_in "password", with: "test1234"
      click_button "Login"

      expect(page.current_path).to eq('/users/test-user')
      expect(page).to have_selector('form')
      expect(page).to have_field(:query)
    end

    it "looks for the book based on it's ISBN number" do

    end

    it "looks for the book based on the author" do

    end

    it "looks for the book based on the title" do

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

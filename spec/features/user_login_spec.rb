require 'spec_helper'

describe "User login" do

  context "GET /login" do
    it "returns a 200 status code" do
      get '/login'

      expect(last_response.status).to eq(200)
    end

    it "displays a login form with fields for username and password" do
      visit '/login'
      expect(page).to have_selector('form')
      expect(page).to have_field(:username)
      expect(page).to have_field(:password)
    end
  end

  context "POST /login" do
    it "displays the user's home page upon successful login" do
      User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
      visit '/login'
      fill_in "username", with: "test user"
      fill_in "password", with: "test1234"
      click_button "Login"

      expect(page.current_path).to eq('/users/test-user')
      expect(page.status_code).to eq(200)
      expect(page.body).to include("Welcome test user")
    end

    # TODO test that a flash message appears
    it "displays a failure message if no username is given" do
      visit '/login'
      fill_in "username", with: ""
      fill_in "password", with: "test1234"
      click_button "Login"

      expect(page.current_path).to eq('/login')
    end

    # TODO test that a flash message appears
    it "displays a failure message if no password is given" do
      visit '/login'
      fill_in "username", with: "test user"
      fill_in "password", with: ""
      click_button "Login"

      expect(page.current_path).to eq('/login')
    end

    # TODO test that a flash message appears
    it "displays a failure message if the account is not found" do
      visit '/login'
      fill_in "username", with: "test user"
      fill_in "password", with: "test1234"
      click_button "Login"

      expect(page.current_path).to eq('/login')
    end

    # TODO test that a flash message appears
    it "displays a failuser message if the username and password combination do not match" do
      User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
      visit '/login'
      fill_in "username", with: "test user"
      fill_in "password", with: "test5678"
      click_button "Login"

      expect(page.current_path).to eq('/login')
    end
  end

end

require 'spec_helper'

describe "User signup" do

  context "GET /signup" do
    it "returns a 200 status code" do
      get '/signup'

      expect(last_response.status).to eq(200)
    end

    it "displays a signup form with fields for username, email and password" do
      visit '/signup'
      expect(page).to have_selector('form')
      expect(page).to have_field(:username)
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
    end
  end

  context "POST /signup" do
    it "displays the user's home page on successful signup" do
      visit '/signup'
      fill_in "username", with: "test user"
      fill_in "email", with: "test@example.com"
      fill_in "password", with: "test1234"
      click_button "Sign up"

      expect(page.current_path).to eq('/users/test-user')
      expect(page.status_code).to eq(200)
      expect(page.body).to include("Welcome test user")
    end

    # TODO test that a flash message appears
    it "displays a failuse message if the username already exists" do
      User.create(username: "test user", email: "test@example.com", password: "test1234")
      visit '/signup'
      fill_in "username", with: "test user"
      fill_in "email", with: "test@example.com"
      fill_in "password", with: "test1234"
      click_button "Sign up"

      expect(page.current_path).to eq('/signup')
      # expect(flash[:messge]).to include("Account already exists")
    end

    # TODO test that a flash message appears
    it "displays a failuse message if the email address already exists" do
      User.create(username: "test user", email: "test@example.com", password: "test1234")
      visit '/signup'
      fill_in "username", with: "user test"
      fill_in "email", with: "test@example.com"
      fill_in "password", with: "test5678"
      click_button "Sign up"

      expect(page.current_path).to eq('/signup')
    end

    # TODO test that a flash message appears
    it "displays a failure message if no username is given" do
      visit '/signup'
      fill_in "username", with: ""
      fill_in "email", with: "test@example.com"
      fill_in "password", with: "test1234"
      click_button "Sign up"

      expect(page.current_path).to eq('/signup')
    end

    # TODO test that a flash message appears
    it "displays a failure message if no email is given" do
      visit '/signup'
      fill_in "username", with: "test user"
      fill_in "email", with: ""
      fill_in "password", with: "test1234"
      click_button "Sign up"

      expect(page.current_path).to eq('/signup')
    end

    # TODO test that a flash message appears
    it "displays a failure message if no password is given" do
      visit '/signup'
      fill_in "username", with: "test user"
      fill_in "email", with: "test@example.com"
      fill_in "password", with: ""
      click_button "Sign up"

      expect(page.current_path).to eq('/signup')
    end
  end
end

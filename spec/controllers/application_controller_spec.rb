require 'spec_helper'

describe 'ApplicationController' do

  describe "Homepage: GET '/'" do
    context "logged in" do
      it "loads the user's home page" do
        user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        get '/', {}, {'rack.session' => {user_id: user.id}}

        expect(last_response.location).to include("/users/#{user.slug}")
      end
    end

    context "logged out" do
      it "loads the login page" do
        get '/'

        expect(last_response.location).to include('/login')
      end

    end
  end

  describe "404, page not found" do
    context "logged in" do
      it "redirects user to 404 page" do
        user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        get '/unknown', {}, {'rack.session' => {user_id: user.id}}

        expect(last_response.body).to include("Page Not Found")
      end
    end

    context "logged out" do
      it "redirects user to login" do
        get '/unknown'

        expect(last_response.location).to include('/login')
      end
    end
  end

end

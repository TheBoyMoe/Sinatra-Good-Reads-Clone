require 'spec_helper'

describe UsersController do

  describe '/signup' do

    context "logged in" do
      it "does not let a user view the signup page" do
        user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        get '/signup', {}, {'rack.session' => {user_id: user.id}}

        expect(last_response.location).to include("/users/#{user.slug}")
      end
    end

    context "logged out" do
      it "loads the signup page" do
        get '/signup'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('Signup')
      end

      it "redirects the user to their home page following user registration" do
        params = {username: 'test user', email: 'test@example.com', password: 'test1234'}
        post '/signup', params
        
        expect(last_response.status).to eq(302)
        expect(last_response.location).to include("/users/test-user")
      end

      it "does not let a user signup without a username" do
        params = {email: 'test@example.com', password: 'test1234'}
        post '/signup', params

        expect(last_response.location).to include('/signup')
      end

      it "does not let a user signup without an email address" do
        params = {username: 'test user', password: 'test1234'}
        post '/signup', params

        expect(last_response.location).to include('/signup')
      end

      it "does not let a user signup without a password" do
        params = {username: 'test user', email: 'test@example.com'}
        post '/signup', params

        expect(last_response.location).to include('/signup')
      end

    end

  end
end

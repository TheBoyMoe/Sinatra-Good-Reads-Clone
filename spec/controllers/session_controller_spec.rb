require 'spec_helper'

describe 'SessionController' do

  describe "/login" do
    context 'logged in' do
      it "redirects the user to the home page" do
        user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        get '/login', {}, {'rack.session' => {user_id: user.id}}

        expect(last_response.location).to include('/home')
      end
    end

    context 'logged out' do
      it "loads the login page" do
        get '/login'

        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('Login')
      end

      it "redirects the user to the home page following successful login" do
        User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        params = {username: 'test user', password: 'test1234'}
        post '/login', params

        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('Welcome')
      end

      it "does not let a user login without providing a username and password" do
        User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        params = {username: 'test user', password: ''}
        post '/login', params

        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_response.body).to include('Login')
      end

      it "re-loads the login page following unsuccessful login" do
        User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        params = {username: 'test user', password: 'password'}
        post '/login', params

        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_response.body).to include('Login')
      end
    end
  end

  describe "/logout" do
    context "logged in" do
      it "to destroy the session and redirect the user to the login page" do
        user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
        get '/logout', {}, {'rack.session' => {user_id: user.id}}

        expect(last_request.session[:user_id]).to eq(nil)
        expect(last_response.location).to include('/login')
      end
    end

    context "logged out" do
      it "redirects the user to the login page" do
        get '/logout'

        expect(last_response.location).to include('/login')
      end
    end
  end

end

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

  end

end

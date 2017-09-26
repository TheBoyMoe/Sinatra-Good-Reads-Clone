require 'spec_helper'

describe UsersController do

  context "logged in" do
    it "does not a user view the signup page" do

    end
  end

  context "logged out" do
    it "loads the signup page" do
      get '/signup'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('Signup')
    end

    it "signup directs the user the home page following user registration" do
      
    end

    it "does not let a user signup without a username" do

    end

    it "does not let a user signup without an email address" do

    end

    it "does not let a user signup without a password" do

    end

  end
end

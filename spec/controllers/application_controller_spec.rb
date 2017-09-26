require 'spec_helper'

describe 'ApplicationController' do

  describe "Homepage: GET '/'" do
    context "logged in" do
      it "loads the home page" do
        # TODO redirect to  '/home'
      end
    end

    context "logged out" do
      it "loads the login page" do
        get '/'

        expect(last_response.location).to include('/login')
      end

    end
  end
end

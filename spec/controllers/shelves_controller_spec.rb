require 'spec_helper'

describe 'ShelvesController' do

  before do
    @tom = User.create(username: 'tom', email: 'tom@example.com', password: '12345678')
    @dick = User.create(username: 'dick', email: 'dick@example.com', password: '12345678')

    @tom.shelves << [
      Shelf.create(title: 'read'),
      Shelf.create(title: 'to-read'),
      Shelf.create(title: 'reading')
    ]
    @tom.save
    book = Book.create(goodreads_id: 76778, title: 'The Martian Chronicles', author: 'Ray Bradbury')
    @tom.shelves.find_by(title: 'read').books << book
  end

  context 'ensure that users can only access their own book shelf' do
    it "allows users to access their own book shelf" do
      get '/login', {}, {'rack.session' => {user_id: @tom.id}}
      get "/shelves/#{@tom.slug}"
      
      expect(last_response.body).to include("My Books")
      expect(last_response.body).to include('The Martian Chronicles')
      expect(last_response.body).to include('Ray Bradbury')
    end

    it "redirects users to the home page displaying welcome message if they try to access someone else's book shelf" do
      get '/login', {}, {'rack.session' => {user_id: @tom.id}}
      get "/shelves/#{@dick.slug}"
      follow_redirect!

      expect(last_response.body).to include("Welcome #{@tom.username}")
    end

    it "redirects logged out users to the login page" do
      get "/shelves/#{@dick.slug}"
      follow_redirect!

      expect(last_response.location).to include('login')
    end
  end

end

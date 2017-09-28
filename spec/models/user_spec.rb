require 'spec_helper'

describe 'User' do

  context 'validations' do
    it "is invalid without a username" do
      expect(User.create(username: nil, email: 'test@example.com', password: 'test1234')).to_not be_valid
    end

    it "is invalid without an email address" do
      expect(User.create(username: 'test user', email: nil, password: 'test1234')).to_not be_valid
    end

    it "is invalid without a password" do
      expect(User.create(username: 'test user', email: 'test@example.com', password: nil)).to_not be_valid
    end

    it "ensures that the username is unique" do
      User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
      user = User.new(username: 'test user', email: 'user@example.com', password: 'test5678')

      expect(user.save).to eq(false)
    end

    it "ensures that the email address is unique" do
      User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
      user = User.new(username: 'user test', email: 'test@example.com', password: 'test5678')

      expect(user.save).to eq(false)
    end
  end

  context 'attributes' do
    user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
    it "has a username" do
      expect(user.username).to eq('test user')
    end

    it "has an email address" do
      expect(user.email).to eq('test@example.com')
    end

    it "has a secure password" do
      expect(user.authenticate('password')).to eq(false)
      expect(user.authenticate('test1234')).to eq(user)
    end
  end

  context "User model implemts 'slug' attribute" do
    before do
      @user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
    end

    it "can slug the username" do
      expect(@user.slug).to eq('test-user')
    end

    it "can find a user based on the slug" do
      expect(User.find_by_slug(@user.slug).username).to eq('test user')
    end
  end


end

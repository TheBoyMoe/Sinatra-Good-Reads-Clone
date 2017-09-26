require 'spec_helper'

describe 'User' do

  before do
    @user = User.create(username: 'test user', email: 'test@example.com', password: 'test1234')
  end

  it "can slug the username" do
    expect(@user.slug).to eq('test-user')
  end

  it "can find a user based on the slug" do
    expect(User.find_by_slug(@user.slug).username).to eq('test user')
  end

  it "has a secure password" do
    expect(@user.authenticate('password')).to eq(false)
    expect(@user.authenticate('test1234')).to eq(@user)
  end

end

require 'spec_helper'

describe 'Shelf' do

  context 'attribures' do
    shelf = Shelf.create(title: 'SciFi', description: 'My SciFi collection')

    it "has a title" do
      expect(shelf.title).to eq('SciFi')
    end

    it "has a description" do
      expect(shelf.description).to eq('My SciFi collection')
    end
  end
end

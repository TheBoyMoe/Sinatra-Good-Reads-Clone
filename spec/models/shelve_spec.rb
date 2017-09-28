require 'spec_helper'

describe 'Shelve' do

  context 'attribures' do
    shelve = Shelve.create(title: 'SciFi', description: 'My SciFi collection')

    it "has a title" do
      expect(shelve.title).to eq('SciFi')
    end

    it "has a description" do
      expect(shelve.description).to eq('My SciFi collection')
    end
  end
end

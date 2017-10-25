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

  describe ".find_by_slug" do
    let!(:to_read_shelf) { Shelf.create(title: 'to-read', user_id: 1) }
    let!(:read_shelf) { Shelf.create(title: 'read', user_id: 2) }

    it 'match found, return slug' do

      expect(Shelf.find_by_slug('to-read', 1)).to eq(to_read_shelf)
    end

    it "no match found, return nil" do
      expect(Shelf.find_by_slug('reading', 1)).to be_nil
    end

    it "should return nil when no shelves exist" do
      Shelf.destroy_all
      expect(Shelf.find_by_slug('read', 2)).to be_nil
    end
  end
end

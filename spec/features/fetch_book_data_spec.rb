require 'spec_helper'

describe 'Fetch book data' do

  context "when a user initiates a search" do

    it "returns a book instance when searching by ISBN" do
      book = FetchBookData.new('9780553278224')

      expect(book).to be_a_instance_of(Book)
      expect(books.first.title).to eq('The Martian Chronicles')
      expect(books.first.author).to eq('Ray Bradbury')
    end

    it "returns an array of book instances when searching by title" do
      books = FetchBookData.new('The Martian Chronicles').parse_xml

      expect(books).to be_a(Array)
      expect(books.first).to be_a_instance_of(Book)
      expect(books.first.title).to eq('The Martian Chronicles')
      expect(books.first.author).to eq('Ray Bradbury')
    end

    it "returns an array of book instances when searching by author" do
      books = FetchBookData.new('Ray Bradbury').parse_xml

      expect(books).to be_a(Array)
      expect(books.first).to be_a_instance_of(Book)
      expect(books.first.author).to eq('Ray Bradbury')
    end

  end
end

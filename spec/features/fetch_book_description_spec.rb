require 'spec_helper'

describe "Fetch book description" do

  let(:book){Book.create(title: 'The Illustrated Man', author: 'Ray Bradbury', goodreads_id: '24830')}

  context "viewing the details of an individual book" do

    it "returns the book description from Goodreads as a string" do
      description = FetchBookDescription.new(book.goodreads_id).parse_xml

      expect(description).to be_a(String)
      expect(description).to include("That <i>The Illustrated Man</i> has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")
    end

    it "updates the book instance with the descrition" do
      FetchBookDescription.new(book.goodreads_id).save_description

      expect(Book.find_by(goodreads_id: book.goodreads_id).description).to include("That <i>The Illustrated Man</i> has remained in print since being published in 1951 is fair testimony to the universal appeal of Ray Bradbury's work.")
    end
  end
end

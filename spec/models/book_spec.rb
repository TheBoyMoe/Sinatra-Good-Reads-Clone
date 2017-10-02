require 'spec_helper'

describe 'Book' do

  context 'attributes' do
    book = Book.create(
      goodreads_id: 1,
      title: '2001, A Space Odyssey',
      author: 'Arthur C Clarke',
      image_url: '/images/cover_images/2001.png',
      description: 'an ancient and unseen alien race uses a device with the appearance of a large crystalline monolith to investigate worlds all across the galaxy and, if possible, to encourage the development of intelligent life.',
      ratings_count: 23456,
      year_published: 1968
    )

    it "has a goodreads book id" do
      expect(book.goodreads_id).to eq(1)
    end

    it "has a title" do
      expect(book.title).to eq('2001, A Space Odyssey')

    end

    it "has an author" do
      expect(book.author).to eq('Arthur C Clarke')
    end


    it "has a cover image" do
      expect(book.image_url).to eq('/images/cover_images/2001.png')
    end

    it "has a description" do
      expect(book.description).to eq('an ancient and unseen alien race uses a device with the appearance of a large crystalline monolith to investigate worlds all across the galaxy and, if possible, to encourage the development of intelligent life.')
    end

    it "has a ratings count" do
      expect(book.ratings_count).to eq(23456)
    end

    it "has a publication year" do
      expect(book.year_published).to eq(1968)
    end

  end

  context "Book model implements 'slug' attribute" do
    before do
      @book = Book.create(title: "2001, A Space Odyssey", author: 'Arthur C Clarke')
    end

    it "can slug the title" do
      expect(@book.title_slug).to eq('2001-a-space-odyssey')
    end

    it "can find a book based on the title slug" do
      expect(Book.find_by_title_slug(@book.title_slug).title).to eq("2001, A Space Odyssey")
    end

    it "can slug the author" do
      expect(@book.author_slug).to eq('arthur-c-clarke')
    end

    it "can find a book based on the author slug" do
      expect(Book.find_by_author_slug(@book.author_slug).author).to eq('Arthur C Clarke')
    end
  end

end

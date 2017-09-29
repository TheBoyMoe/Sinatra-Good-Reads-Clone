class Book < ActiveRecord::Base
  has_many :reviews
  has_many :book_shelves
  has_many :shelves, through: :book_shelves

  def isbn_slug
    isbn13.gsub(/ -/, '')
  end

  def self.find_by_isbn_slug(slug)
    Book.all.find do |book|
      book.isbn_slug == slug
    end
  end

  def title_slug
    title.downcase.gsub(/[,()#{}:]/, '').gsub(' ', '-')
  end

  def self.find_by_title_slug(slug)
    Book.all.find do |book|
      book.title_slug == slug
    end
  end

  def author_slug
    author.downcase.gsub(' ', '-')
  end

  def self.find_by_author_slug(slug)
    Book.all.find do |book|
      book.author_slug == slug
    end
  end
end

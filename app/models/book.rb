class Book < ActiveRecord::Base
  has_many :reviews
  has_many :book_shelves
  has_many :shelves, through: :book_shelves

  def title_slug
    title.downcase.gsub(/[,'(){}:]/, '').gsub('#', '').gsub(' ', '-')
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

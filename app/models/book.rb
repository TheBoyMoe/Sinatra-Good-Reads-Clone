class Book < ActiveRecord::Base
  has_many :reviews
  has_many :book_shelves
  has_many :shelves, through: :book_shelves

  def title_slug
    title.downcase.gsub(/[,'(){}:]/, '').gsub(/\?/, '').gsub(/\./, '').gsub('#', '').gsub(' ', '-')
  end

  def self.find_by_title_slug(slug)
    Book.all.find do |book|
      book.title_slug == slug
    end
  end

  def author_slug
    author.downcase.gsub(/\./, '').gsub(' ', '-')
  end

  def self.find_by_author_slug(slug)
    # REVIEW: ?? add_column to books table
    # Very inefficient. You can use the Book.find_by(author_slug: slug)
    # http://api.rubyonrails.org/v5.1/classes/ActiveRecord/FinderMethods.html#method-i-find_by
    Book.all.find do |book|
      book.author_slug == slug
    end
  end
end

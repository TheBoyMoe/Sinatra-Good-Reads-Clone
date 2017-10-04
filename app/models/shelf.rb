class Shelf < ActiveRecord::Base
  belongs_to :user
  has_many :book_shelves
  has_many :books, through: :book_shelves

  def slug
    title.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug, current_user_id)
    Shelf.all.find do |shelf|
      shelf.slug == slug && shelf.user_id == current_user_id
    end
  end
  
end

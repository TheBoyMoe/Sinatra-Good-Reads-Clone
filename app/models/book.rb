class Book < ActiveRecord::Base
  has_many :reviews
  has_many :book_shelves
  has_many :shelves, through: :book_shelves
end

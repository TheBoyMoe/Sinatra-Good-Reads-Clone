class Shelve < ActiveRecord::Base
  belongs_to :users
  has_many :book_shelves
  has_many :books, through: :book_shelves
end

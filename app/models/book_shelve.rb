class BookShelve < ActiveRecord::Base
  belongs_to :book
  belongs_to :shelve
end

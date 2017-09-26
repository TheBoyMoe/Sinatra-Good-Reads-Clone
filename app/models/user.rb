class User < ActiveRecord::Base
  has_many :shelves

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true
  
end

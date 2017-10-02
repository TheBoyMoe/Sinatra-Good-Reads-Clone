class AddShelveNameAndReviewCountToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :book_shelve_name, :string
    add_column :books, :reviews_count, :integer
  end
end

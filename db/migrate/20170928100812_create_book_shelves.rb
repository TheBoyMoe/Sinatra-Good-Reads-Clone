class CreateBookShelves < ActiveRecord::Migration[5.1]
  def change
    create_table :book_shelves do |t|
      t.integer :book_id
      t.integer :shelve_id
    end
  end
end

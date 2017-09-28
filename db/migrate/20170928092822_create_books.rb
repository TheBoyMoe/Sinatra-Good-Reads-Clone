class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :goodread_book_id
      t.string :isbn13
      t.string :title
      t.string :author
      t.string :publisher
      t.string :image
      t.text :description
      t.integer :ratings_count
      t.integer :ratings_sum
      t.integer :year
    end
  end
end

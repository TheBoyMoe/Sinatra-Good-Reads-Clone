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
      t.decimal :ratings_average
      t.integer :year_published
    end
  end
end

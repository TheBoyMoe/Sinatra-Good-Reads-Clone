class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :goodreads_id
      t.string :title
      t.string :author
      t.string :image_url
      t.integer :year_published
      t.decimal :ratings_average
      t.integer :ratings_count
      t.integer :reviews_count
      t.string :book_shelf_name
      t.text :description
    end
  end
end

class CreateShelves < ActiveRecord::Migration[5.1]
  def change
    create_table :shelves do |t|
      t.string :title
      t.text :description
      t.integer :user_id
    end
  end
end

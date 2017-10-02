class AddRatingsAvgToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :ratings_average, :real
  end
end

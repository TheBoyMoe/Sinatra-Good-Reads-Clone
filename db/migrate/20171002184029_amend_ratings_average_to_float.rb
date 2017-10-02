class AmendRatingsAverageToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :ratings_average, :float
  end
end

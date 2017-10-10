class AddTimestampToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :created_at, :datetime, default: nil
    add_column :reviews, :updated_at, :datetime, default: nil
  end
end

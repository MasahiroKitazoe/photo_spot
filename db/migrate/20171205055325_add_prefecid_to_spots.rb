class AddPrefecidToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :prefecture_id, :integer
  end
end

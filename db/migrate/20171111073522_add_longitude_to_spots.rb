class AddLongitudeToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :longitude, :decimal, precision: 8, scale: 6
    add_column :spots, :latitude, :decimal, precision: 9, scale: 6
  end
end

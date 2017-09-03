class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|

      t.string         :name
      t.integer        :user_id
      t.string         :prefecture
      t.string         :city
      t.timestamps
    end
  end
end

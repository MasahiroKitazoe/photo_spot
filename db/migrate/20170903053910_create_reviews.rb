class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer           :rate
      t.text              :comment
      t.integer           :user_id
      t.integer           :spot_id
      t.timestamps
    end
  end
end

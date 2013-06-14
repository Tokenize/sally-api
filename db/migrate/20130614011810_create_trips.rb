class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.references :user

      t.timestamps
    end
    add_index :trips, :user_id
  end
end

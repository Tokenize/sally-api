class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.timestamp :time
      t.float :latitude
      t.float :longitude
      t.string :direction
      t.integer :speed
      t.references :trip

      t.timestamps
    end
    add_index :locations, :trip_id
  end
end

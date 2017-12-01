class CreateHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :homes do |t|
      t.integer :user_id
      t.integer :notification_id
      t.integer :option_id
      t.float :latitude
      t.float :longitude
      t.text :description
      t.text :title
      t.string :address
      t.float :price
      t.integer :size
      t.date :start_date
      t.date :end_date
      t.integer :total_rooms
      t.integer :available_rooms
      t.integer :available_beds
      t.float :total_bathrooms
      t.float :private_bathrooms
      t.boolean :is_furnished
      t.integer :capacity
      t.boolean :entire_home
      t.integer :driving_distance
      t.integer :driving_duration
      t.integer :bicycling_distance
      t.integer :bicycling_duration
      t.integer :transit_distance
      t.integer :transit_duration
      t.integer :walking_distance
      t.integer :walking_duration
      t.string :status

      t.timestamps
    end
  end
end

class CreateHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :homes do |t|
      t.integer :user_id
      t.integer :gallery_id
      t.integer :notification_id
      t.integer :option_id
      t.text :description
      t.string :address
      t.float :price
      t.integer :size
      t.date :start_date
      t.date :end_date
      t.integer :total_rooms
      t.integer :available_rooms
      t.float :total_bathrooms
      t.float :private_bathrooms
      t.boolean :is_furnished

      t.timestamps
    end
  end
end

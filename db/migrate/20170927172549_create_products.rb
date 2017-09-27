class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :user_id
      t.string :address
      t.float :price
      t.text :description
      t.integer :size
      t.date :start_date
      t.date :end_date
      t.float :bathrooms
      t.integer :total_rooms
      t.float :rooms_available
      t.boolean :is_furnished

      t.timestamps
    end
  end
end

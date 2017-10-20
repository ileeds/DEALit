class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.float :size_of_house
      t.integer :capacity
      t.boolean :free_parking
      t.boolean :street_parking
      t.float :deposit
      t.float :broker
      t.boolean :pets
      t.integer :beds
      t.boolean :heated
      t.boolean :ac
      t.boolean :tv
      t.boolean :dryer
      t.boolean :dish_washer
      t.boolean :fireplace
      t.boolean :kitchen
      t.boolean :garbage_disposal
      t.boolean :wireless
      t.boolean :lock
      t.boolean :elevator
      t.boolean :pool
      t.boolean :gym
      t.boolean :wheelchair
      t.boolean :hot_tub
      t.boolean :smoking
      t.boolean :events
      t.boolean :subletting
      t.boolean :utilities_included
      t.float :water_price
      t.float :heat_price
      t.boolean :closet
      t.boolean :porch
      t.boolean :lawn
      t.boolean :patio
      t.boolean :storage
      t.integer :floors
      t.boolean :refrigerator
      t.boolean :stove
      t.boolean :microwave
      t.boolean :laundry
      t.boolean :laundry_free
      t.boolean :bike
      t.boolean :soundproof
      t.boolean :intercom
      t.boolean :gated
      t.boolean :doorman
      t.boolean :house
      t.boolean :apartment

      t.timestamps
    end
  end
end

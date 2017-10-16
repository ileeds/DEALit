class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :home_id
      t.integer :user_id
      t.string :description

      t.timestamps
    end
  end
end

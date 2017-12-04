class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :home_id

      t.timestamps
    end
  end
end

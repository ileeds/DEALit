class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :home_id
      t.string :filename

      t.timestamps
    end
  end
end

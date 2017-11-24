class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :gallery_id
      t.string :filename

      t.timestamps
    end
  end
end

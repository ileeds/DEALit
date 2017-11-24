class AddHomeIdToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :home_id, :integer
  end
end

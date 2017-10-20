class AddHomeIdToOption < ActiveRecord::Migration[5.1]
  def change
    add_column :options, :home_id, :integer
  end
end

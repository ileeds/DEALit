class AddHomeIdToOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :options, :home_id, :integer
    remove_column :homes, :option_id, :integer
  end
end

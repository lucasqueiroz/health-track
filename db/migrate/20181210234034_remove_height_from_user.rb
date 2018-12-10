class RemoveHeightFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :height, :float
  end
end

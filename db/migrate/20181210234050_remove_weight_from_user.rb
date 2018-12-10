class RemoveWeightFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :weight, :integer
  end
end

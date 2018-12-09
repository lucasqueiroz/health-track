class CreateHeights < ActiveRecord::Migration[5.2]
  def change
    create_table :heights do |t|
      t.references :user, foreign_key: true
      t.float :measurement
      t.date :measured_at

      t.timestamps
    end
  end
end

class CreateWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :weights do |t|
      t.references :user, foreign_key: true
      t.integer :measurement
      t.date :measured_at

      t.timestamps
    end
  end
end

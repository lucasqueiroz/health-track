class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :calories
      t.date :occurred_at

      t.timestamps
    end
  end
end

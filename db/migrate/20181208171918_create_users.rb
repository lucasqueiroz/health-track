class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.float :height
      t.integer :weight
      t.string :password_digest

      t.timestamps
    end
  end
end

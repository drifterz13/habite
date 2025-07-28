class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :level
      t.integer :hp
      t.integer :atk
      t.integer :def
      t.integer :gold

      t.timestamps
    end
  end
end

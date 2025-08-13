class CreateMonsters < ActiveRecord::Migration[8.0]
  def change
    create_table :monsters do |t|
      t.string :title
      t.string :description
      t.integer :atk
      t.integer :def
      t.integer :hp
      t.string :asset_key

      t.timestamps
    end
  end
end

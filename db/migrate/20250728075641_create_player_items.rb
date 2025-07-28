class CreatePlayerItems < ActiveRecord::Migration[8.0]
  def change
    create_table :player_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.boolean :equipped

      t.timestamps
    end
  end
end

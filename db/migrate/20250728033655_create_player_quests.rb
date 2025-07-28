class CreatePlayerQuests < ActiveRecord::Migration[8.0]
  def change
    create_table :player_quests do |t|
      t.references :player, null: false, foreign_key: true
      t.references :quest, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end

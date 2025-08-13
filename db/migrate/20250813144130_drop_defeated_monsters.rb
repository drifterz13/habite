class DropDefeatedMonsters < ActiveRecord::Migration[8.0]
  def change
    drop_table :defeated_monsters
  end
end

class AddDefeaterIdToMonster < ActiveRecord::Migration[8.0]
  def change
    add_reference :monsters, :player, null: false, foreign_key: true
  end
end

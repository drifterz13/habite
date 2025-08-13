class ChangePlayerIdNullInMonsters < ActiveRecord::Migration[8.0]
  def change
    change_column_null :monsters, :player_id, true
  end
end

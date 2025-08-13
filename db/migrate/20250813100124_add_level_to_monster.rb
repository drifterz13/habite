class AddLevelToMonster < ActiveRecord::Migration[8.0]
  def change
    add_column :monsters, :level, :integer, null: false
  end
end

class AddPosToPlayerItem < ActiveRecord::Migration[8.0]
  def change
    add_column :player_items, :pos, :integer
  end
end

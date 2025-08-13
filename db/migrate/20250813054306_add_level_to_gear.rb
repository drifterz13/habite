class AddLevelToGear < ActiveRecord::Migration[8.0]
  def change
    add_column :gears, :level, :integer
  end
end

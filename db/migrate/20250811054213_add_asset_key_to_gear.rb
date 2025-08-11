class AddAssetKeyToGear < ActiveRecord::Migration[8.0]
  def change
    add_column :gears, :asset_key, :string
  end
end

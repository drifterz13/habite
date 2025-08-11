namespace :seeder do
  task gears: [ :environment ]  do
    dir_name = "app/assets/images/gears"
    gear_entries = Dir.entries dir_name

    gear_asset_keys = gear_entries
      .select { |entry| entry.end_with? ".png" }
      .map { |asset_name| asset_name.gsub(".png", "") }

    gear_asset_keys.each do |gear_asset_key|
      title = gear_asset_key.humanize

      gear = Gear.new(title:, asset_key: gear_asset_key)
      gear.save!
    end
  end
end

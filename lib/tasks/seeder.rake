namespace :seeder do
  task game_masters: [ :environment ] do
    base_stats = { level: 1, hp: 100, exp: 0, atk: 10, def: 8, gold: 10 }
    emails = [ "gm1@test.com", "gm2@test.com" ]

    emails.each do |email|
      user = User.new({
        email_address: email,
        password: "P@ssw0rd",
        password_confirmation: "P@ssw0rd"
      })
      user.build_player({ name: email.split("@").first }.merge(base_stats))
      user.save!
    end
  end

  task gears: [ :environment ]  do
    dir_name = "app/assets/images/gears"
    gear_entries = Dir.entries dir_name

    gear_asset_keys = gear_entries
      .select { |entry| entry.end_with? ".png" }
      .map { |asset_name| asset_name.gsub(".png", "") }

    gear_asset_keys.each do |gear_asset_key|
      title = gear_asset_key.humanize
      level = gear_asset_key.split("_")[1].to_i

      gear = Gear.new(title:, asset_key: gear_asset_key, level:)
      gear.save!
    end
  end
end

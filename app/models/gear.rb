# == Schema Information
#
# Table name: gears
#
#  id          :integer          not null, primary key
#  atk         :integer
#  def         :integer
#  description :string
#  hp          :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Gear < ApplicationRecord
  has_one :item, as: :itemable, touch: true

  WEAPONS = %w[
    Wooden\ Sword Iron\ Sword Hunter's\ Bow
    axe_1 axe_2 axe_3 axe_4
    sword_1 sword_2 sword_3 sword_4
    crimson_sword_1 crimson_sword_2 crimson_sword_3
    knuckle_1 knuckle_2 knuckle_3
  ]
  ARMORS = %w[
    Wooden\ Shield
    hat_1 hat_2 hat_3
    helmet_1 helmet_2 helmet_3
    vest_1 vest_2 vest_3
    shoe_1 shoe_2 3
  ]
  GEARS = [ WEAPONS, ARMORS ].flatten
  STAT_MULTIPLIER = 8

  def self.randomize!
    item_name = GEARS.sample.humanize

    gear = new(
      title: item_name,
      description: "Basic item that's named: #{item_name}"
    )

    if gear.is_weapon?
      gear.atk = gear.rand_stat
    end

    if gear.is_armor?
      gear.hp = gear.rand_stat / 2
      gear.def = gear.rand_stat / 2
    end

    gear.save!
    gear
  end

  def rand_stat
    rand(item_lv * STAT_MULTIPLIER)
  end

  def item_lv
    title.split("_").last.to_i
  end

  def is_weapon?
    formatted_title = title.downcase.gsub(" ", "_")
    WEAPONS.include? title or WEAPONS.include? formatted_title
  end

  def is_armor?
    formatted_title = title.downcase.gsub(" ", "_")
    ARMORS.include? title or ARMORS.include? formatted_title
  end
end

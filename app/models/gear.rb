# == Schema Information
#
# Table name: gears
#
#  id          :integer          not null, primary key
#  asset_key   :string
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
  has_many :quest_rewards, as: :rewardable

  before_create :set_gear_stats, if: :no_stats?

  WEAPONS = %w[
    axe_1 axe_2 axe_3 axe_4
    sword_1 sword_2 sword_3 sword_4
    crimson_sword_1 crimson_sword_2 crimson_sword_3
    knuckle_1 knuckle_2 knuckle_3
  ]
  ARMORS = %w[
    hat_1 hat_2 hat_3
    helmet_1 helmet_2 helmet_3
    vest_1 vest_2 vest_3
    shoe_1 shoe_2 shoe_3
  ]
  GEARS = [ WEAPONS, ARMORS ].flatten
  STAT_MULTIPLIER = 8

  def self.randomize!(available_gears = GEARS)
    rand_gear = available_gears.sample
    Gear.find_by(asset_key: rand_gear)
  end

  def rand_stat
    base_stats = rand(item_lv * STAT_MULTIPLIER)
    if is_weapon?
      base_stats
    elsif is_armor?
      (base_stats / rand(1.0..2.0)).round 1
    end
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

  private

  def no_stats?
    (is_weapon? && self.atk.nil?) ||
      (is_armor? && (self.def.nil? || self.hp.nil?))
  end

  def set_gear_stats
    if is_weapon?
      self.atk = rand_stat
    end

    if is_armor?
      self.hp = rand_stat
      self.def = rand_stat
    end
  end
end

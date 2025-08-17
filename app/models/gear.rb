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
#  level       :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Gear < ApplicationRecord
  has_one :item, as: :itemable, touch: true

  has_many :quest_rewards, as: :rewardable
  has_many :monster_rewards, as: :rewardable

  before_create :set_level, if: -> { _1.level.nil? }
  before_create :set_stats, if: :no_stats?

  WEAPONS = %w[
    axe_1 axe_2 axe_3 axe_4
    sword_1 sword_2 sword_3 sword_4
    crimson_sword_1 crimson_sword_2 crimson_sword_3
    knuckle_1 knuckle_2 knuckle_3
  ]
  ARMORS = %w[
    hat_1 hat_2 hat_3
    helmet_1 helmet_2 helmet_3
    vest_1 vest_2 vest_3 vest_4
    shoe_1 shoe_2 shoe_3
  ]
  GEARS = [ WEAPONS, ARMORS ].flatten
  STAT_MULTIPLIER = 8

  def self.randomize!
    Gear.all.sample
  end

  def apply_to(player)
    player.items.create!(itemable: self)
  end

  def is_weapon?
    WEAPONS.include? asset_key
  end

  def is_armor?
    ARMORS.include? asset_key
  end

  def level
    if persisted?
      level ||= asset_key.split("_").last.to_i
    else
      1
    end
  end

  private

  def no_stats?
    if is_weapon?
      return self.atk.nil?
    end

    self.def.nil? && self.hp.nil?
  end

  def rand_stat
    base_stats = rand(1..level * STAT_MULTIPLIER)

    if is_weapon?
      base_stats
    elsif is_armor?
      divider = [ base_stats, STAT_MULTIPLIER ].min.to_f
      (base_stats / divider).round 1
    end
  end

  def set_stats
    if is_weapon?
      self.atk = rand_stat
      self.def = 0
      self.hp = 0
    end

    if is_armor?
      self.atk = 0
      self.hp = rand_stat
      self.def = rand_stat
    end
  end

  def set_level = self.level = get_level
end

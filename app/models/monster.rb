# == Schema Information
#
# Table name: monsters
#
#  id          :integer          not null, primary key
#  asset_key   :string
#  atk         :integer
#  def         :integer
#  description :string
#  hp          :integer
#  level       :integer          not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  player_id   :integer          not null
#
# Indexes
#
#  index_monsters_on_player_id  (player_id)
#
# Foreign Keys
#
#  player_id  (player_id => players.id)
#
class Monster < ApplicationRecord
  include Rewardable, Spawnable

  belongs_to :defeater, class_name: "Player", foreign_key: "player_id", optional: true

  validates :title, length: { maximum: 100 }, presence: true
  validates :hp, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :atk, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :def, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :level, presence: true, numericality: { greater_than: 0, lesser_than_or_equal_to: 64 }

  scope :defeated, -> { where.not(defeater: nil) }
  scope :undefeated, -> { where(defeater: nil) }

  def lesser_tier? = (1..20).include? level
  def champion_tier? = (21..40).include? level
  def boss_tier? = (41..64).include? level

  def defeated_by(player)
    transaction do
      self.defeater = player
      self.save!

      player.receive_rewards_from self
    end
  end

  def take_damage(damage)
    if self.hp < damage
      self.hp = 0
    else
      self.hp -= damage
    end

    self.save!
  end

  def is_dead? = hp == 0

  def image_path = "mons/#{asset_key}.png"

  def original_stats
    monsters_data.find { _1["level"] == self.level }
  end

  def monsters_data
    data_path = Rails.root.join "app", "assets", "data", "monsters.json"
    data = File.read data_path
    JSON.parse data
  end
end

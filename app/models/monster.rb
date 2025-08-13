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
  belongs_to :defeater, class_name: "Player", foreign_key: "player_id", optional: true
  has_many :monster_rewards, dependent: :destroy

  validates :title, length: { maximum: 100 }, presence: true
  validates :hp, presence: true, numericality: { greater_than: 0 }
  validates :atk, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :def, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :level, presence: true, numericality: { greater_than: 0, lesser_than_or_equal_to: 64 }
  validate :can_spawn, on: :create

  scope :defeated, -> { where.not(defeater: nil) }

  after_create :randomize_rewards!

  def spawn!(level = randomize_monster_level)
    monster = monsters_data.find { _1["level"] == level }
    self.attributes = monster
    save!
  end

  def can_spawn
    can_spawn = Monster.defeated.count == Monster.count
    errors.add(:monster, "cannot spawn new monster when some monsters still alive") unless can_spawn
  end

  def lesser_tier? = (1..20).include? level
  def champion_tier? = (21..40).include? level
  def boss_tier? = (41..64).include? level

  def defeated_by(player)
    self.defeater = player
    self.save!
  end

  private

  def randomize_rewards!
    3.times.each do
      reward_type = randomize_reward_type.to_s.constantize
      reward = reward_type.randomize!
      monster_rewards.create! rewardable: reward
    end
  end

  def randomize_reward_type
    rewards = %i[Gear GoldReward ExpReward]
    weights = [ 35, 35, 30 ]
    cumulative = 0
    random = rand weights.sum

    weights.each_with_index do |weight, idx|
      cumulative += weight
      return rewards[idx] if cumulative >= random
    end
  end

  def monsters_data
    data_path = Rails.root.join "app", "assets", "data", "monsters.json"
    data = File.read data_path
    JSON.parse data
  end

  def level_range_from(tier)
    case tier
    when :lesser
      1..20
    when :champion
      21..40
    else
      41..64
    end
  end

  def randomize_monster_tier
    monster_tiers = %i[lesser champion boss]
    weights = [ 85, 10, 5 ]
    cumulative = 0
    random = rand weights.sum

    weights.each_with_index do |weight, idx|
      cumulative += weight
      return monster_tiers[idx] if cumulative >= random
    end
  end

  def randomize_monster_level
    tier = randomize_monster_tier
    rand level_range_from(tier)
  end
end

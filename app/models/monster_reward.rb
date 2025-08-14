# == Schema Information
#
# Table name: monster_rewards
#
#  id              :integer          not null, primary key
#  rewardable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  monster_id      :integer          not null
#  rewardable_id   :integer          not null
#
# Indexes
#
#  index_monster_rewards_on_monster_id  (monster_id)
#  index_monster_rewards_on_rewardable  (rewardable_type,rewardable_id)
#
# Foreign Keys
#
#  monster_id  (monster_id => monsters.id)
#
class MonsterReward < ApplicationRecord
  belongs_to :rewardable, polymorphic: true
  belongs_to :monster

  def is_exp? = rewardable.is_a? ExpReward
  def is_gold? = rewardable.is_a? GoldReward
  def is_gear? = rewardable.is_a? Gear
end

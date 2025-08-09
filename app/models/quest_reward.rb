# == Schema Information
#
# Table name: quest_rewards
#
#  id              :integer          not null, primary key
#  rewardable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  quest_id        :integer          not null
#  rewardable_id   :integer          not null
#
# Indexes
#
#  index_quest_rewards_on_quest_id    (quest_id)
#  index_quest_rewards_on_rewardable  (rewardable_type,rewardable_id)
#
# Foreign Keys
#
#  quest_id  (quest_id => quests.id)
#
class QuestReward < ApplicationRecord
  belongs_to :quest
  belongs_to :rewardable, polymorphic: true

  REWARD_TYPES = {
    "ExpReward": 0.5,
    "GoldReward": 0.5,
    "NoneReward": 0.2,
    "Gear": 0.1
  }.freeze

  def is_exp?
    rewardable_type == "ExpReward"
  end

  def is_gold?
    rewardable_type == "GoldReward"
  end

  def is_gear?
    rewardable_type == "Gear"
  end

  def randomize!
    reward_type = randomize_reward_type.to_s
    reward_class = reward_type.constantize

    self.rewardable = reward_class.randomize!
    self.save! unless rewardable.nil?
  end

  private

  def normalized_reward_types
    weight = REWARD_TYPES.values.sum

    REWARD_TYPES.map do |reward_type, percentage|
      [ reward_type, (percentage / weight).round(2) ]
    end.to_h
  end

  def randomize_reward_type
    drop_chance = rand

    normalized_reward_types.find do |reward_type, percentage|
      reward_type if percentage <= drop_chance
    end.first
  end
end

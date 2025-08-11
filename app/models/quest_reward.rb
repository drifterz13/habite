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
    "ExpReward": 50,
    "GoldReward": 50,
    "NoneReward": 20,
    "Gear": 10
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

  # Distribute rewards in to its own range and check whether
  # random number falls into which range
  def randomize_reward_type
    items = REWARD_TYPES.keys
    weights = REWARD_TYPES.values

    random_number = rand weights.sum
    weight_cumulative = 0

    items.each_with_index do |item, idx|
      weight_cumulative += weights[idx]

      return item if random_number < weight_cumulative
    end
  end
end

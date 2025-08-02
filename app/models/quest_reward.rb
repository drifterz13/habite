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

  def is_exp?
    rewardable_type == "ExpReward"
  end

  def is_gold?
    rewardable_type == "GoldReward"
  end

  def is_gear?
    rewardable_type == "Gear"
  end
end

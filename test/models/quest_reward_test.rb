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
require "test_helper"

class QuestRewardTest < ActiveSupport::TestCase
  test "is_exp?" do
    reward = quest_rewards(:exp_reward)
    assert reward.is_exp?, "Reward type should be ExpReward"
  end

  test "is_gold?" do
    reward = quest_rewards(:gold_reward)
    assert reward.is_gold?, "Reward type should be GoldReward"
  end

  test "is_gear?" do
    reward = quest_rewards(:gear_reward)
    assert reward.is_gear?, "Reward type should be Gear"
  end

  test "randomize!" do
    quest_reward = QuestReward.new quest: quests(:todo)
    quest_reward.randomize!
    assert_operator QuestReward.count, :>=, 0
  end
end

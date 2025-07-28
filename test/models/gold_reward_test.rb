# == Schema Information
#
# Table name: gold_rewards
#
#  id         :integer          not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class GoldRewardTest < ActiveSupport::TestCase
  test "call apply_to player" do
    player = players(:one)
    gold_reward = gold_rewards(:twenty_gold)

    assert_difference -> { player.gold }, 20 do
      gold_reward.apply_to player
    end
  end
end

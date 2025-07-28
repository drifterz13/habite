# == Schema Information
#
# Table name: exp_rewards
#
#  id         :integer          not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ExpRewardTest < ActiveSupport::TestCase
  test "call apply_to player" do
    player = players(:one)
    exp_reward = exp_rewards(:ten_exp)

    assert_difference -> { player.exp }, 10 do
      exp_reward.apply_to player
    end
  end
end

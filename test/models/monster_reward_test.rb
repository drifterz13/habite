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
require "test_helper"

class MonsterRewardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

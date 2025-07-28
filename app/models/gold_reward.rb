# == Schema Information
#
# Table name: gold_rewards
#
#  id         :integer          not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class GoldReward < ApplicationRecord
  has_one :quest_reward, as: :rewardable, dependent: :destroy
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def apply_to(player)
    player.update!(gold: amount)
  end
end

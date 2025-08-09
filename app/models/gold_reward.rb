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
  validates :amount, presence: true, numericality: { greater_than: 1 }

  MIN_GOLD = 1
  MAX_GOLD = 10

  def apply_to(player)
    player.update!(gold: amount)
  end

  def self.randomize!
    create! amount: rand(MIN_GOLD..MAX_GOLD)
  end
end

# == Schema Information
#
# Table name: exp_rewards
#
#  id         :integer          not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ExpReward < ApplicationRecord
  has_one :quest_reward, as: :rewardable, dependent: :destroy
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  MIN_EXP = 1
  MAX_EXP = 10

  def apply_to(player)
    player.update!(exp: amount)
  end

  def self.randomize!
    create! amount: rand(MIN_EXP..MAX_EXP)
  end
end

module Monster::Rewardable
  extend ActiveSupport::Concern

  included do
    has_many :monster_rewards, dependent: :destroy
    after_create :randomize_rewards!
  end

  def rewards = monster_rewards

  private

  def randomize_rewards!
    3.times.each do
      reward_type = randomize_reward_type.to_s.constantize
      reward = reward_type.randomize!
      monster_rewards.create! rewardable: reward
    end
  end

  def randomize_reward_type
    rewards = %i[Gear GoldReward ExpReward]
    weights = [ 35, 35, 30 ]
    cumulative = 0
    random = rand weights.sum

    weights.each_with_index do |weight, idx|
      cumulative += weight
      return rewards[idx] if cumulative >= random
    end
  end
end

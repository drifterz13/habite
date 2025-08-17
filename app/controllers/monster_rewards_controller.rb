class MonsterRewardsController < ApplicationController
  def index
    @monster = Monster.includes(monster_rewards: :rewardable)
      .find params.expect(:monster_id)
  end
end

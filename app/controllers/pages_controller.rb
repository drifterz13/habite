class PagesController < ApplicationController
  def home
    @player = Player.includes(quests: :tasks).find_by(user: Current.user)
  end

  def boss
    @player = Player.find_by user: Current.user
    @monster = Monster.includes(monster_rewards: :rewardable).undefeated.first
  end
end

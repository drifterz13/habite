class Gm::MonstersController < ApplicationController
  # TODO: Handle access to gm routes
  def show
    @player = Player.find_by(user: Current.user)
    @monster = Monster.includes(monster_rewards: :rewardable).undefeated.first
  end

  def create
    @monster = Monster.new.spawn!

    if @monster.errors.empty?
      redirect_to monsters_path, notice: "Boss: #{@monster.title} has been spawned!"
    else
      render monsters_path, status: :unprocessable_entity
    end
  end
end

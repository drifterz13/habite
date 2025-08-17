class MonstersController < ApplicationController
  before_action :set_player
  before_action :ensure_boss_spawned?, only: %i[attack]

  def index
    @monster = Monster.includes(monster_rewards: :rewardable).undefeated.first
  end

  def attack
    @monster ||= Monster.find_by(id: params.expect(:id))

    respond_to do |format|
      @player.attack(@monster)

      if @monster.is_dead?
        @monster.defeated_by @player
        format.html { redirect_to monsters_path, notice: "Boss: #{@monster.title} is defeated!" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("boss_hp",
            partial: "monsters/boss_hp",
            locals: { monster: @monster }
          )
        end
      end
    end
  end

  private

  def set_player
    @player = Player.find_by user: Current.user
  end

  def ensure_boss_spawned?
    @monster = Monster.find_by(id: params.expect(:id))
    render monsters_path, status: :unprocessable_entity if @monster.nil?
  end
end

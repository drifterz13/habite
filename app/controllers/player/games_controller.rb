class Player::GamesController < ApplicationController
  before_action :set_player
  before_action :set_monster, only: %i[attack_monster]
  before_action :ensure_boss_spawned?, only: %i[attack_monster]

  def attack_monster
    respond_to do |format|
      @player.attack(@monster)

      if @monster.is_dead?
        @monster.defeated_by @player
        format.html { redirect_to boss_fight_path, notice: "Boss: #{@monster.title} is defeated!" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("boss_hp",
            partial: "games/boss_hp",
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

  def set_monster
    @monster = Monster.find_by(id: params.expect(:id))
  end

  def ensure_boss_spawned?
    render boss_fight_path, status: :unprocessable_entity if @monster.nil?
  end
end

class Player::GamesController < ApplicationController
  def attack_monster
    @monster = Monster.find(params.expect :id)

    respond_to do |format|
      if @monster && current_player.attack(@monster)
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "boss_hp",
            partial: "games/boss_hp",
            locals: { monster: @monster }
          )
        end
      else
        format.html { redirect_to boss_fight_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def current_player
    @player ||= Player.find_by user: Current.user
  end
end

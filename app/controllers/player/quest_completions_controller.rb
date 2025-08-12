class Player::QuestCompletionsController < ApplicationController
  def complete
    quest = Quest.find params.expect(:id)

    respond_to do |format|
      if current_player.complete_quest(quest)
        format.html { redirect_to quests_path, notice: "Quest has been completed" }
      else
        format.html { redirect_to quest_path(quest), alert: "Failed to complete quest" }
      end
    end
  end

  private

  def current_player
    @player ||= Current.user.player
  end
end

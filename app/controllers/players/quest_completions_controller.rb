class Players::QuestCompletionsController < ApplicationController
  def complete
    quest = Quest.find params.expect(:id)

    respond_to do |format|
      if Current.user.player.complete_quest(quest)
        format.html { redirect_to quests_path, notice: "Quest has been completed" }
      else
        format.html { redirect_to quest_path(quest), alert: "Failed to complete quest." }
      end
    end
  end
end

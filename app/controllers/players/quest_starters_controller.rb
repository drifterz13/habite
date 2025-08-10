class Players::QuestStartersController < ApplicationController
  def start
    quest = Quest.find params.expect(:id)

    respond_to do |format|
      if Current.user.player.start_quest!(quest)
        format.html { redirect_to quests_path, notice: "Quest has been started" }
      else
        format.html { redirect_to quest_path(quest), alert: "Failed to start quest." }
      end
    end
  end
end

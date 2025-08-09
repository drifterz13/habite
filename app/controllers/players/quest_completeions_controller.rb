class Players::QuestCompletion < ApplicationController
  def complete
    player = Player.find_by(user: Current.user)
    quest = Quest.find params.expect(:quest_id)

    respond_to do |format|
      if player.complete_quest quest
        format.html { redirect_to quests_path, notice: "Quest has been completed" }
      else
        format.html { redirect_to quest_path(quest), notice: "Failed to complete quest." }
      end
    end
  end
end

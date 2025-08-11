class Player::TaskCompletionsController < ApplicationController
  def complete
    quest = Quest.find params.expect(:quest_id)
    task = Task.find params.expect(:id)

    respond_to do |format|
      if Current.user.player.complete_task(task)
        format.html { redirect_to quest_path(quest), notice: "Task has been completed" }
      else
        format.html { redirect_to quest_path(quest), alert: "Failed to complete task." }
      end
    end
  end
end

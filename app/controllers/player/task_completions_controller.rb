class Player::TaskCompletionsController < ApplicationController
  def complete
    task = Task.find params.expect(:id)

    respond_to do |format|
      if Current.user.player.complete_task(task)
        format.html { redirect_to quest_path(task.quest), notice: "Task has been completed" }
      else
        format.html { redirect_to quest_path(task.quest), alert: "Failed to complete task." }
      end
    end
  end
end

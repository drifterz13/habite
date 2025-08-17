class TasksController < ApplicationController
  before_action :set_current_player
  before_action :set_task

  def show
  end

  def complete
    respond_to do |format|
      if @player.complete_task(@task)
        format.html { redirect_to quest_path(@task.quest), notice: "Task has been completed" }
      else
        format.html { redirect_to quest_path(@task.quest), alert: "Failed to complete task." }
      end
    end
  end

  private

  def set_task
    @task = Task.find params.expect(:id)
  end

  def set_current_player
    @player = Player.find_by(user: Current.user)
  end
end

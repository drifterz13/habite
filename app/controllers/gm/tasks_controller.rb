class Gm::TasksController < ApplicationController
  before_action :set_quest, only: %i[ new create ]

  def new
  end

  def create
    @quest.tasks.build task_params

    respond_to do |format|
      if @quest.save
        format.html { redirect_to @quest, notice: "Create quest task successfully." }
      else
        format.html { render new_gm_quest_tasks_path, alert: "Failed to create quest task." }
      end
    end
  end

  private

  def set_quest
    @quest = Quest.find(params.expect(:quest_id))
  end

  def task_params
    params.expect(task: [ :title, :description, :start_at, :end_at ])
  end
end

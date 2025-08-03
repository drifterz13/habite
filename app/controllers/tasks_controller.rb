class TasksController < ApplicationController
  def show
    @player = Player.find_by(user_id: Current.user.id)
    @task = Task.find params.expect(:id)
  end
end

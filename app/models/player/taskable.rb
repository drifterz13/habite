module Player::Taskable
  extend ActiveSupport::Concern

  included do
    has_many :player_tasks, dependent: :destroy
    has_many :tasks, through: :player_tasks
  end

  def complete_task(task)
    player_task = player_tasks.find_by(task:)
    can_complete_task?(task) && player_task.complete
  end

  def completed_task_at(task)
    player_tasks.find_by(task:)&.completed_at
  end

  def can_complete_task?(task)
    task.in_completable_period? && !task.completed_by?(self)
  end

  def has_completed_task?(task)
    task.completed_by?(self)
  end
end

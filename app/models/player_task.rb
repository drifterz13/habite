# == Schema Information
#
# Table name: player_tasks
#
#  id           :integer          not null, primary key
#  completed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  player_id    :integer          not null
#  task_id      :integer          not null
#
# Indexes
#
#  index_player_tasks_on_player_id  (player_id)
#  index_player_tasks_on_task_id    (task_id)
#
# Foreign Keys
#
#  player_id  (player_id => players.id)
#  task_id    (task_id => tasks.id)
#
class PlayerTask < ApplicationRecord
  belongs_to :player
  belongs_to :task

  def completed?
    !!completed_at
  end
end

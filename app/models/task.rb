# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  description :text
#  end_at      :datetime
#  start_at    :datetime
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quest_id    :integer          not null
#
# Indexes
#
#  index_tasks_on_quest_id  (quest_id)
#
# Foreign Keys
#
#  quest_id  (quest_id => quests.id)
#
class Task < ApplicationRecord
  include Completable

  belongs_to :quest
  has_many :player_tasks, dependent: :destroy

  def completed_by?(player)
    player_tasks.where(player:).where.not(completed_at: nil).exists?
  end
end

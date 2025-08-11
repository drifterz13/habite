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

  validate :quest_not_started_by_some_players

  def completed_by?(player)
    player_tasks.where(player:).where.not(completed_at: nil).exists?
  end

  private

  def quest_not_started_by_some_players
    if quest.has_started_by_some_players?
      errors.add(:task, "cannot create task for on-going quest")
    end
  end
end

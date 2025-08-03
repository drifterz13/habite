# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  atk        :integer
#  def        :integer
#  exp        :integer          default(0)
#  gold       :integer
#  hp         :integer
#  level      :integer
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_players_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Player < ApplicationRecord
  belongs_to :user

  has_many :player_items, dependent: :destroy
  has_many :items, through: :player_items

  has_many :player_quests, dependent: :destroy
  has_many :quests, through: :player_quests

  has_many :player_tasks, dependent: :destroy
  has_many :tasks, through: :player_tasks

  scope :with_items, ->(player_id) { includes(player_items: :item).find(player_id) }

  def equipped_items
    player_items.select(&:equipped?)
  end

  def has_completed?(quest_or_task)
    if quest_or_task.is_a? Task
      has_completed_task? quest_or_task
    elsif quest_or_task.is_a? Quest
      has_completed_quest? quest_or_task
    end
  end

  def has_completed_task_at(task)
    player_task_from(task)&.completed_at
  end

  def completed_tasks_count(quest)
    player_tasks.where(task_id: quest.task_ids).where.not(completed_at: nil).count
  end

  def player_task_from(task)
    player_tasks.find_by(task_id: task.id)
  end

  private

  def has_completed_task?(task)
    player_task_from(task).completed_at.present?
  end

  def has_completed_quest?(quest)
    completed_tasks_count(quest) == quest.task_ids.size
  end
end

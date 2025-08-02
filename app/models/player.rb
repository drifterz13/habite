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
    player_items.select { _1.equipped? }
  end

  def has_completed?(quest_or_task)
    if quest_or_task.is_a? Task
      has_completed_task? quest_or_task
    elsif quest_or_task.is_a? Quest
      has_completed_quest? quest_or_task
    end
  end

  private

  def has_completed_task?(task)
    !!player_tasks.find { task.id = _1.task_id }&.completed_at
  end

  def has_completed_quest?(quest)
    quest_task_ids = quest.tasks.map(&:id)
    player_tasks.all? { quest_task_ids.include?(_1.task_id) and _1.completed? }
  end
end

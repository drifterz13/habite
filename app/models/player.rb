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

  def has_started_quest?(quest)
    quest.owned_by?(self)
  end

  def start_quest!(quest)
    has_started_quest?(quest) || player_quests.create!(player: self, quest:)
  end

  def complete_quest(quest)
    player_quest = player_quests.find_by(quest:)
    can_complete_quest?(quest) && player_quest.complete
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

  def can_complete_quest?(quest)
    has_started_quest?(quest) &&
    quest.in_completable_period? &&
    quest.all_tasks_completed_by?(self) &&
    !quest.completed_by?(self)
  end

  def has_completed_quest?(quest)
    quest.all_tasks_completed_by?(self) && quest.completed_by?(self)
  end

  def has_completed_task?(task)
    task.completed_by?(self)
  end
end

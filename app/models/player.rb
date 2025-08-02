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
  scope :with_player_tasks, -> { includes(:player_tasks) }

  def equipped_items
    player_items.select { _1.equipped? }
  end

  def has_completed?(task)
    if task.is_a? Task
      !!player_tasks.find { task.id = _1.task_id }&.completed_at
    end
  end
end

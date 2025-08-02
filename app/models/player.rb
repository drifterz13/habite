# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  atk        :integer
#  def        :integer
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
end

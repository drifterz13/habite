# == Schema Information
#
# Table name: player_items
#
#  id         :integer          not null, primary key
#  equipped   :boolean
#  pos        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#  player_id  :integer          not null
#
# Indexes
#
#  index_player_items_on_item_id    (item_id)
#  index_player_items_on_player_id  (player_id)
#
# Foreign Keys
#
#  item_id    (item_id => items.id)
#  player_id  (player_id => players.id)
#
class PlayerItem < ApplicationRecord
  belongs_to :item
  belongs_to :player

  validates :pos, presence: true, numericality: { greather_than_or_equal_to: 1, less_than_or_equal_to: 20 }

  scope :from_owner, ->(player) { where(player:) }

  before_validation :set_item_pos, if: :no_pos?

  def equipped?
    !!equipped
  end

  def set_item_pos
    positions = PlayerItem.from_owner(self.player).pluck :pos
    self.pos = (positions.max || 0) + 1
  end

  def no_pos?
    pos.nil?
  end
end

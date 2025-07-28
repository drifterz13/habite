# == Schema Information
#
# Table name: player_items
#
#  id         :integer          not null, primary key
#  equipped   :boolean
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

  def equipped?
    !!equipped
  end
end

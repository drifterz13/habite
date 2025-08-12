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
require "test_helper"

class PlayerItemTest < ActiveSupport::TestCase
  test "returns equipped player item" do
    equipped_player_item = player_items(:one)
    unequipped_player_item = player_items(:two)

    assert equipped_player_item.equipped?
    assert_not unequipped_player_item.equipped?
  end

  test "set_item_position" do
    player = players(:one)
    item = items(:without_owner)

    assert_difference -> { PlayerItem.from_owner(player).pluck(:pos).max }, 1 do
      PlayerItem.create!(player:, item:)
    end
  end
end

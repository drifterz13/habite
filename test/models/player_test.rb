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
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "should returns equipped items" do
    player = Player.with_items players(:one).id
    equipped_items = player.equipped_items

    assert_equal 1, equipped_items.size
    assert_equal "Wood sword", equipped_items.first.item.title
  end
end

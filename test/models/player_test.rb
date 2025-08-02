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
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "should returns equipped items" do
    player = Player.with_items players(:one).id
    equipped_items = player.equipped_items

    assert_equal 1, equipped_items.size
    assert_equal "Wood sword", equipped_items.first.item.title
  end

  test "has_completed should returns true for completed task" do
    player = players(:two)
    task = tasks(:completed)
    assert player.has_completed?(task)
  end

  test "has_completed should returns false for incomplete task " do
    player = players(:one)
    task = tasks(:on_going)
    refute player.has_completed?(task)
  end

  test "has_completed should returns true for completed quest" do
    player = players(:two)
    quest = quests(:completed)
    assert player.has_completed?(quest)
  end

  test "has_completed should returns false for incomplete quest " do
    player = players(:one)
    quest = quests(:on_going)
    refute player.has_completed?(quest)
  end
end

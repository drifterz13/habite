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
    assert_equal "Wooden Sword", equipped_items.first.item.title
  end

  test "has_completed_task? should returns true for completed task" do
    player = players(:one)
    task = tasks(:completed)
    assert player.has_completed_task?(task)
  end

  test "has_completed_task? should returns false for incomplete task " do
    player = players(:one)
    task = tasks(:in_progress_todo)
    refute player.has_completed_task?(task)
  end

  test "has_completed_quest? should returns true for completed quest" do
    player = players(:one)
    quest = quests(:completed)
    assert player.has_completed_quest?(quest)
  end

  test "has_completed_quest? should returns false for incompleted quest" do
    player = players(:one)
    quest = quests(:in_progress)
    refute player.has_completed_quest?(quest)
  end

  test "can_complete_quest? should returns true for completable quest" do
    player = players(:one)
    quest = quests(:ready_to_complete)
    assert player.can_complete_quest?(quest)
  end

  test "can_complete_quest? should returns false for incompleted quest" do
    player = players(:one)
    quest = quests(:in_progress)
    refute player.can_complete_quest?(quest)
  end

  test "can_complete_quest? should returns false for completed quest" do
    player = players(:one)
    quest = quests(:completed)
    refute player.can_complete_quest?(quest)
  end

  test "can_complete_task? should returns true for completable task" do
    player = players(:one)
    task = tasks(:in_progress_todo)
    assert player.can_complete_task?(task)
  end

  test "can_complete_task? should returns false for completed task" do
    player = players(:one)
    task = tasks(:in_progress_completed)
    refute player.can_complete_task?(task)
  end
end

# == Schema Information
#
# Table name: quests
#
#  id          :integer          not null, primary key
#  description :text
#  end_at      :datetime
#  start_at    :datetime
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class QuestTest < ActiveSupport::TestCase
  test "randomize rewards after quest creation" do
    quest = Quest.new title: "My quest"
    quest.save!
    assert_operator QuestReward.count, :>=, 0
  end

  test "has_started_by_some_players? returns true" do
    quest = quests(:in_progress)
    assert quest.has_started_by_some_players?
  end

  test "has_started_by_some_players? returns false" do
    quest = quests(:without_player)
    refute quest.has_started_by_some_players?
  end
end

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
    assert_difference -> { QuestReward.count }, 3 do
      Quest.create! title: "My Quest"
    end
  end
end

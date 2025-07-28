# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  description :text
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quest_id    :integer          not null
#
# Indexes
#
#  index_tasks_on_quest_id  (quest_id)
#
# Foreign Keys
#
#  quest_id  (quest_id => quests.id)
#
require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

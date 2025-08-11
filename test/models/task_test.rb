# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  description :text
#  end_at      :datetime
#  start_at    :datetime
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
  test "set_default_task_period for unspecify start_at and end_at task" do
    quest = quests(:without_player)
    task = Task.create! quest:, title: "My Task"

    assert task.start_at.present?
    assert task.end_at.present?
  end

  test "in_completable_period? given task is in completion period" do
    task = tasks(:in_progress_todo)
    assert task.in_completable_period?
  end

  test "in_completable_period? given task is not in completion period" do
    task = tasks(:completed)
    refute task.in_completable_period?
  end

  test "quest_not_started_by_some_players should add errors" do
    quest = quests(:in_progress)
    task = quest.tasks.build title: "Test Task"

    refute task.valid?
    assert_includes task.errors[:task], "cannot create task for on-going quest"
  end

  test "quest_not_started_by_some_players should not add errors" do
    quest = quests(:without_player)
    task = quest.tasks.build title: "Test Task"

    assert task.valid?
  end
end

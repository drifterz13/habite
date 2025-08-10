require "test_helper"

class TaskCompletionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should complete task" do
    quest = quests(:in_progress)
    task = tasks(:in_progress_todo)

    patch complete_quest_task_url(quest, task)

    assert_redirected_to quest_url(quest)
    assert_equal "Task has been completed", flash[:notice]
  end
end

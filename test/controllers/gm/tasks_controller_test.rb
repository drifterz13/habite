require "test_helper"

class Gm::TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:gm)
    sign_in(user)
  end

  test "should get new" do
    quest = quests(:todo)
    get new_gm_quest_task_url(quest)
    assert_response :success
  end

  test "should create task for quest" do
    quest = quests(:without_player)
    post gm_quest_tasks_url(quest), params: {
      task: { title: "Test Task" }
    }
    assert_redirected_to quest_url(quest)
  end
end

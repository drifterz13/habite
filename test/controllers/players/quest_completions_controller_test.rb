require "test_helper"

class QuestCompletionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should complete quest" do
    quest = quests(:ready_to_complete)
    patch complete_quest_url(quest)
    assert_redirected_to quests_url
  end
end

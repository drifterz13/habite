require "test_helper"

class QuestStartersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should start quest" do
    quest = quests(:without_player)
    post start_quest_url(quest)
    assert_redirected_to quests_url
  end
end

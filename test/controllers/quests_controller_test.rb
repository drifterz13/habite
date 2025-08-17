require "test_helper"

class QuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should get index" do
    get quests_url
    assert_response :success
  end

  test "should show quest" do
    quest = quests(:in_progress)
    get quest_url(quest)
    assert_response :success
  end

  test "should start quest" do
    quest = quests(:without_player)
    post start_quest_url(quest)
    assert_redirected_to quests_url
  end

  test "should complete quest" do
    quest = quests(:ready_to_complete)
    patch complete_quest_url(quest)

    assert_redirected_to quests_url
    assert_equal "Quest has been completed", flash[:notice]
  end
end

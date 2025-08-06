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

  test "should get new" do
    get new_quest_url
    assert_response :success
  end

  test "should create quest" do
    assert_difference("Quest.count") do
      start_at = Time.now + 1.days
      end_at = start_at + 1.days

      post quests_url, params: { quest: { title: "Asking peer to review work", description: "Request for MR review", end_at:, start_at: } }
    end

    assert_redirected_to quest_url(Quest.last)
  end

  test "should show quest" do
    quest = quests(:in_progress)
    get quest_url(quest)
    assert_response :success
  end

  test "should get edit" do
    quest = quests(:in_progress)
    get edit_quest_url(quest)
    assert_response :success
  end

  test "should update quest" do
    quest = quests(:in_progress)
    patch quest_url(quest), params: { quest: { end_at: Time.now + 2.days } }
    assert_redirected_to quest_url(quest)
  end

  test "should destroy quest" do
    quest = quests(:in_progress)
    assert_difference("Quest.count", -1) do
      delete quest_url(quest)
    end

    assert_redirected_to quests_url
  end
end

require "test_helper"

class Gm::QuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:gm)
    sign_in(user)
  end

  test "should get new" do
    get new_gm_quest_url
    assert_response :success
  end

  test "should create quest" do
    assert_difference("Quest.count") do
      start_at = Time.now + 1.days
      end_at = start_at + 1.days

      post gm_quests_url, params: { quest: { title: "Asking peer to review work", description: "Request for MR review", end_at:, start_at: } }
    end

    assert_redirected_to quest_url(Quest.last)
  end

  test "should destroy quest" do
    quest = quests(:in_progress)
    assert_difference("Quest.count", -1) do
      delete gm_quest_url(quest)
    end

    assert_redirected_to quests_url
  end
end

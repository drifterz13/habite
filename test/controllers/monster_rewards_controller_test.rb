require "test_helper"

class MonsterRewardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should get index" do
    monster = monsters(:lesser_tier)
    get monster_rewards_url monster
    assert_response :success
  end
end

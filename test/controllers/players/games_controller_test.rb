require "test_helper"

class Player::GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should attack monster" do
    monster = monsters(:lesser_tier)
    post attack_monster_url(monster), as: :turbo_stream

    assert_response :success
  end
end

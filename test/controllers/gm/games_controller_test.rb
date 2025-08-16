require "test_helper"

class Gm::GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gm)
    sign_in(@user)
  end

  test "should spawn monster and redirect" do
    # defeat remaining monster first before continue
    monster = monsters(:boss_tier)
    monster.defeated_by @user.player

    post gm_spawn_monster_url

    assert_redirected_to boss_fight_url

    re = /Boss: [\w\s]+ has been spawned!/
    assert_match re, flash[:notice]
  end

  test "should not spawn monster and redirect" do
    post gm_spawn_monster_url
    assert_response :unprocessable_entity
  end
end

require "test_helper"

class Gm::MonstersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:gm)
    sign_in(@user)
  end

  test "should spawn monster and redirect" do
    # defeat remaining monster first before continue
    monsters(:boss_tier).defeated_by @user.player

    post gm_monsters_url

    # get newly spawned monster
    assert_redirected_to monsters_url

    re = /Boss: [\w\s]+ has been spawned!/
    assert_match re, flash[:notice]
  end

  test "should not spawn monster and redirect" do
    post gm_monsters_url
    assert_response :unprocessable_entity
  end
end

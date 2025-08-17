require "test_helper"

class MonstersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should render boss fight page" do
    # monster = Monster.new(id: 1234)
    # post attack_monster_url(monster)

    # assert_response :unprocessable_entity
    # assert_routing "/pages/boss", controller: "pages", action: "boss"

    get monsters_url
    assert_response :success
  end

  test "should attack monster" do
    monster = monsters(:lesser_tier)
    post attack_monster_url(monster), as: :turbo_stream

    assert_response :success
  end

  test "should show flash message when monster is defeated" do
    monster = monsters(:lesser_tier)
    monster.take_damage(monster.hp - 1)

    post attack_monster_url(monster)

    assert_redirected_to monster_rewards_path monster
    assert_equal "Boss: #{monster.title} is defeated!", flash[:notice]
  end
end

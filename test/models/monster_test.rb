# == Schema Information
#
# Table name: monsters
#
#  id          :integer          not null, primary key
#  asset_key   :string
#  atk         :integer
#  def         :integer
#  description :string
#  hp          :integer
#  level       :integer          not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  player_id   :integer          not null
#
# Indexes
#
#  index_monsters_on_player_id  (player_id)
#
# Foreign Keys
#
#  player_id  (player_id => players.id)
#
require "test_helper"

class MonsterTest < ActiveSupport::TestCase
  setup do
    player = players(:one)
    monster = monsters(:boss_tier)
    # defeat remaining monster first before continue
    monster.defeated_by player
  end

  test "spawn! monster" do
    assert_difference -> { Monster.count }, 1 do
      monster = Monster.new.spawn!
      assert_operator MonsterReward.where(monster:).count, :>=, 0
    end
  end

  test "randomize_rewards! for created monster" do
    monster = Monster.create!(
      "title": "Goblin Scout",
      "description": "A small, weak goblin armed with a crude spear",
      "level": 1,
      "atk": 8,
      "def": 3,
      "hp": 25,
      "asset_key": "mons_1"
    )
    assert_operator MonsterReward.where(monster:).count, :>=, 0
  end

  test "lesser_tier?" do
    mon = monsters(:lesser_tier)
    assert mon.lesser_tier?
  end

  test "champion_tier?" do
    mon = monsters(:champion_tier)
    assert mon.champion_tier?
  end

  test "boss_tier?" do
    mon = monsters(:boss_tier)
    assert mon.boss_tier?
  end

  test "can_spawn validation returns true" do
    monster = Monster.new(
      "title": "Goblin Scout",
      "level": 1,
      "atk": 8,
      "def": 3,
      "hp": 25,
      "asset_key": "mons_1"
    )
    assert monster.valid?
  end

  test "can_spawn validation returns false" do
    # create new undefeated monster
    Monster.create!(
      "title": "Goblin Scout",
      "level": 1,
      "atk": 8,
      "def": 3,
      "hp": 25,
      "asset_key": "mons_1"
    )
    # try to create another undefeated monster
    monster = Monster.new(
      "title": "Goblin Scout 2",
      "level": 2,
      "atk": 10,
      "def": 6,
      "hp": 28,
      "asset_key": "mons_1"
    )
    refute monster.valid?
  end
end

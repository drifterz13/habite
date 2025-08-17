# == Schema Information
#
# Table name: gears
#
#  id          :integer          not null, primary key
#  asset_key   :string
#  atk         :integer
#  def         :integer
#  description :string
#  hp          :integer
#  level       :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class GearTest < ActiveSupport::TestCase
  test "randomize! gear" do
    rand_gear = Gear.randomize!
    assert rand_gear.present?
  end

  test "apply_to player" do
    player = players(:one)
    gear = gears(:without_owner)

    assert_difference -> { PlayerItem.where(player:).count }, 1 do
      gear.apply_to player
    end
  end

  test "is_weapon? true, given non formatted gear title" do
    gear = gears(:sword_1)
    assert gear.is_weapon?
    refute gear.is_armor?
  end

  test "is neither armor or weapon" do
    gear = Gear.new title: "Some Gear", atk: 12
    refute gear.is_weapon?
    refute gear.is_armor?
  end

  test "is_armor? true, given non formatted gear title" do
    gear = gears(:vest_1)
    assert gear.is_armor?
    refute gear.is_weapon?
  end

  test "set_gear_stats" do
    weapon_gear = Gear.create!(title: "Crimson Sword 3", asset_key: "crimson_sword_3", level: 3)
    armor_gear = Gear.create!(title: "Vest 2", asset_key: "vest_2")

    assert_equal weapon_gear.def, 0
    assert_equal weapon_gear.hp, 0
    assert_operator weapon_gear.atk, :>, 0

    assert_equal armor_gear.atk, 0
    assert_operator armor_gear.def, :>, 0
    assert_operator armor_gear.hp, :>, 0
  end

  test "not set_gear_stats" do
    weapon_gear = Gear.create!(title: "Crimson Sword 3", asset_key: "crimson_sword_3", atk: 20)
    armor_gear = Gear.create!(title: "Vest 2", asset_key: "vest_2", def: 15, hp: 10)

    assert_equal weapon_gear.atk, 20
    assert_equal armor_gear.def, 15
    assert_equal armor_gear.hp, 10
  end
end

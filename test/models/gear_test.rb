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
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class GearTest < ActiveSupport::TestCase
  test "randomize gear" do
    available_gears = %w[axe_1 helmet_1]

    rand_gear = Gear.randomize! available_gears
    assert rand_gear.present?
    assert_equal rand_gear.class, Gear
  end

  test "is_weapon? true, given non formatted gear title" do
    gear = gears(:sword_1)
    assert gear.is_weapon?
    refute gear.is_armor?
  end

  test "is_weapon? true, given formatted gear title" do
    gear = Gear.new title: "crimson_sword_2", atk: 21
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

  test "is_armor? true, given formatted gear title" do
    gear = Gear.new title: "vest_2", hp: 10, def: 10
    assert gear.is_armor?
    refute gear.is_weapon?
  end

  test "item_lv returns correctly" do
    gear = Gear.new title: "helmet_3", hp: 10, def: 10
    assert_equal 3, gear.item_lv
  end
end

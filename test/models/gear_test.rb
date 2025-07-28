# == Schema Information
#
# Table name: gears
#
#  id          :integer          not null, primary key
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
  # test "the truth" do
  #   assert true
  # end
end

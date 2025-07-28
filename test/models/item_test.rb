# == Schema Information
#
# Table name: items
#
#  id            :integer          not null, primary key
#  itemable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  itemable_id   :integer
#
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

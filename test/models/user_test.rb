# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is_gm? given user have game master email address" do
    user = users(:gm)
    assert user.is_gm?
  end

  test "is_gm? given user have player email address" do
    user = users(:player)
    refute user.is_gm?
  end
end

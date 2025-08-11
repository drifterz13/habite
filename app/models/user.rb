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
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :player, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  GM_EMAILS = [ "gm1@test.com", "gm2@test.com" ]

  def is_gm?
    GM_EMAILS.include? email_address
  end
end

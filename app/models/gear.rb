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
class Gear < ApplicationRecord
  include Item::Itemable
end

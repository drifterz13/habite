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
class Item < ApplicationRecord
  delegated_type :itemable, types: %w[ Gear ], dependent: :destroy
  delegate :title, to: :itemable
  delegate :description, to: :itemable
  delegate :asset_key, to: :itemable

  has_many :owners, through: :player_items, source: :player, dependent: :destroy
end

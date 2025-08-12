# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  atk        :integer
#  def        :integer
#  exp        :integer          default(0)
#  gold       :integer
#  hp         :integer
#  level      :integer
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_players_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Player < ApplicationRecord
  include Questable, Taskable

  belongs_to :user

  has_many :player_items, dependent: :destroy
  has_many :items, through: :player_items

  delegate :is_gm?, to: :user

  scope :with_items, -> { includes(player_items: [ item: :itemable ]) }

  def equipped_items
    player_items.select(&:equipped?)
  end

  def receive_rewards_from(quest)
    quest.rewards.each do |reward|
      if reward.is_exp?
        self.exp += reward.rewardable.amount
      elsif reward.is_gold?
        self.gold += reward.rewardable.amount
      elsif reward.is_gear?
        items.create!(itemable: reward.rewardable)
      end
    end

    self.save!
  end
end

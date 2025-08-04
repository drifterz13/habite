# == Schema Information
#
# Table name: quests
#
#  id          :integer          not null, primary key
#  description :text
#  end_at      :datetime
#  start_at    :datetime
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Quest < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :player_quests, dependent: :destroy
  has_many :players, through: :player_quests
  has_many :quest_rewards, dependent: :destroy

  validates :title, length: { maximum: 100 }, presence: true

  def rewards
    quest_rewards
  end

  def rewardables
    quest_rewards.includes(:rewardable).map(&:rewardable)
  end

  def end?
    end_at < Time.now
  end
end

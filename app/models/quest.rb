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

  after_create :randomize_rewards

  validates :title, length: { maximum: 100 }, presence: true

  def rewards
    quest_rewards
  end

  def end?
    end_at < Time.now
  end

  def randomize_rewards
    3.times.each do
      quest_reward = self.quest_rewards.build
      quest_reward.randomize!
    end
  end
end

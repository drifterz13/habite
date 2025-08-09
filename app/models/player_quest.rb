# == Schema Information
#
# Table name: player_quests
#
#  id           :integer          not null, primary key
#  completed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  player_id    :integer          not null
#  quest_id     :integer          not null
#
# Indexes
#
#  index_player_quests_on_player_id  (player_id)
#  index_player_quests_on_quest_id   (quest_id)
#
# Foreign Keys
#
#  player_id  (player_id => players.id)
#  quest_id   (quest_id => quests.id)
#
class PlayerQuest < ApplicationRecord
  belongs_to :player
  belongs_to :quest

  scope :completed, -> { where.not(completed_at: nil) }

  def completed?
    !!completed_at
  end

  def complete
    self.completed_at = Time.now
    save
  end
end

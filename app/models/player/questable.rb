module Player::Questable
  extend ActiveSupport::Concern

  included do
    has_many :player_quests, dependent: :destroy
    has_many :quests, through: :player_quests
  end

  def start_quest!(quest)
    has_started_quest?(quest) || player_quests.create!(player: self, quest:)
  end

  def has_started_quest?(quest)
    player_quests.where(quest:).exists?
  end

  def has_completed_quest?(quest)
    quest.all_tasks_completed_by?(self) && quest.completed_by?(self)
  end

  def complete_quest(quest)
    player_quest = player_quests.find_by(quest:)
    can_complete_quest?(quest) && player_quest.complete
  end

  def can_complete_quest?(quest)
    has_started_quest?(quest) &&
    quest.in_completable_period? &&
    quest.all_tasks_completed_by?(self) &&
    !quest.completed_by?(self)
  end
end

module Player::Questable
  extend ActiveSupport::Concern

  included do
    has_many :player_quests, dependent: :destroy
    has_many :quests, through: :player_quests
  end

  def start_quest!(quest)
    unless has_started_quest?(quest)
      transaction do
        player_quests.create!(player: self, quest:)

        quest.tasks.each do |task|
          player_tasks.create!(player: self, task:)
        end
      end
    end
  end

  def has_started_quest?(quest)
    player_quests.where(quest:).exists?
  end

  def has_completed_quest?(quest)
    quest.all_tasks_completed_by?(self) && quest.completed_by?(self)
  end

  def complete_quest(quest)
    player_quest = player_quests.find_by(quest:)

    if can_complete_quest?(quest)
      transaction do
        player_quest.complete
        receive_rewards_from quest
      end
    end
  end

  def can_complete_quest?(quest)
    has_started_quest?(quest) &&
    quest.in_completable_period? &&
    quest.all_tasks_completed_by?(self) &&
    !quest.completed_by?(self)
  end
end

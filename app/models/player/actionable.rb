module Player::Actionable
  extend ActiveSupport::Concern

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

  def complete_quest(quest)
    player_quest = player_quests.find_by(quest:)

    if can_complete_quest?(quest)
      transaction do
        player_quest.complete
        receive_rewards_from quest
      end
    end
  end

  def complete_task(task)
    player_task = player_tasks.find_by(task:)
    can_complete_task?(task) && player_task.complete
  end
end

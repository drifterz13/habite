class QuestsController < ApplicationController
  before_action :set_current_player, only: %i[index show start complete compact]
  before_action :set_quest, only: %i[start complete]

  def index
    @quests = Quest.limit 10
  end

  def show
    quest_id = params.expect(:id)
    @quest = Quest.includes(:tasks, { quest_rewards: :rewardable }).find(quest_id)
  end

  def start
    respond_to do |format|
      if @player.start_quest!(@quest)
        format.html { redirect_to quests_path, notice: "Quest has been started" }
      else
        format.html { redirect_to quest_path(@quest), alert: "Failed to start quest." }
      end
    end
  end

  def complete
    respond_to do |format|
      if @player.complete_quest(@quest)
        format.html { redirect_to quests_path, notice: "Quest has been completed" }
      else
        format.html { redirect_to quest_path(@quest), alert: "Failed to complete quest" }
      end
    end
  end

  def compact
    @quest = Quest.find params.expect(:id)
  end

  private

  def set_quest
    @quest = Quest.find params.expect(:id)
  end

  def set_current_player
    @player = Player.find_by(user: Current.user)
  end
end

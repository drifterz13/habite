class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ edit update destroy ]

  def index
    @quests = Quest.includes(:tasks).all
    @player = Player.find_by(user: Current.user)
  end

  def show
    quest_id = params.expect(:id)
    @quest = Quest.includes(:tasks, { quest_rewards: :rewardable }).find(quest_id)
    @player = Player.find_by(user_id: Current.user.id)
  end

  def new
    @quest = Quest.new
  end

  def edit
  end

  def create
    @quest = Quest.new(quest_params)

    respond_to do |format|
      if @quest.save
        format.html { redirect_to @quest, notice: "Quest was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quest.update(quest_params)
        format.html { redirect_to @quest, notice: "Quest was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quest.destroy!

    respond_to do |format|
      format.html { redirect_to quests_path, status: :see_other, notice: "Quest was successfully destroyed." }
    end
  end

  private
    def set_quest
      @quest = Quest.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def quest_params
      params.expect(quest: [ :title, :description, :completed_at, :start_at, :end_at ])
    end
end

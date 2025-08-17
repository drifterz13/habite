class Gm::QuestsController < QuestsController
  before_action :set_quest, only: %i[destroy]

  def new
    @quest = Quest.new
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

    def quest_params
      params.expect(quest: [ :title, :description, :completed_at, :start_at, :end_at ])
    end
end

class PagesController < ApplicationController
  before_action :set_current_player

  def home
  end

  private

  def set_current_player
    @player = Player.preload(:quests, :tasks).find_by(user: Current.user)
  end
end

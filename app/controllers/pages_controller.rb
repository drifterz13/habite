class PagesController < ApplicationController
  def home
    @player = Player.includes(:quests).find_by(user: Current.user)
  end

  def shop
  end
end

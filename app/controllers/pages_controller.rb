class PagesController < ApplicationController
  def home
    @player = Player.includes(quests: :tasks).find_by(user: Current.user)
  end
end

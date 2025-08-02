class PagesController < ApplicationController
  def home
    @quests = Quest.all
  end
end

class ProfilesController < ApplicationController
  def show
    @player = Player.with_items.find_by(user: Current.user)
  end
end

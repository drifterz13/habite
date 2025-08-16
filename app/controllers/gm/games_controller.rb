class Gm::GamesController < Player::GamesController
  def spawn_monster
    @monster = Monster.new
    @monste.spawn!
  end
end

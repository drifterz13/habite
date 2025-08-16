class Gm::GamesController < Player::GamesController
  def spawn_monster
    monster = Monster.new
    @monster = monster.spawn!

    if @monster.errors.empty?
      redirect_to boss_fight_path, notice: "Boss: #{@monster.title} has been spawned!"
    else
      render boss_fight_path, status: :unprocessable_entity
    end
  end
end

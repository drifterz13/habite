class AddMonsterIdToMonsterReward < ActiveRecord::Migration[8.0]
  def change
    add_reference :monster_rewards, :monster, null: false, foreign_key: true
  end
end

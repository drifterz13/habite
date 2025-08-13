class CreateMonsterRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :monster_rewards do |t|
      t.references :rewardable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

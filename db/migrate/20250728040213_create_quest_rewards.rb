class CreateQuestRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :quest_rewards do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :rewardable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

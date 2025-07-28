class CreateGoldRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :gold_rewards do |t|
      t.integer :amount

      t.timestamps
    end
  end
end

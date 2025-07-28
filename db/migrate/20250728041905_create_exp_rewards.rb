class CreateExpRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :exp_rewards do |t|
      t.integer :amount

      t.timestamps
    end
  end
end

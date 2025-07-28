class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :itemable_type
      t.integer :itemable_id

      t.timestamps
    end
  end
end

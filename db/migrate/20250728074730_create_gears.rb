class CreateGears < ActiveRecord::Migration[8.0]
  def change
    create_table :gears do |t|
      t.string :title
      t.string :description
      t.integer :hp
      t.integer :atk
      t.integer :def

      t.timestamps
    end
  end
end

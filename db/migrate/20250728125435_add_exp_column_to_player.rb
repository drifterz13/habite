class AddExpColumnToPlayer < ActiveRecord::Migration[8.0]
  def change
    add_column :players, :exp, :integer, default: 0
  end
end

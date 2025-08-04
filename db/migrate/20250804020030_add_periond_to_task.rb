class AddPeriondToTask < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :start_at, :datetime
    add_column :tasks, :end_at, :datetime
  end
end

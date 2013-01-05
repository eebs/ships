class ChangeNextDueType < ActiveRecord::Migration
  def change
    change_column :runs, :next_due, :date
  end
end

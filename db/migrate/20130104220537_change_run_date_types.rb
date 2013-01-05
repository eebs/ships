class ChangeRunDateTypes < ActiveRecord::Migration
  def change
    change_column :runs, :next_due, :string
    change_column :runs, :start_date, :string
    change_column :runs, :sell_date, :string
  end
end

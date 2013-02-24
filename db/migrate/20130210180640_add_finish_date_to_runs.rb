class AddFinishDateToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :finish_date, :string
  end
end

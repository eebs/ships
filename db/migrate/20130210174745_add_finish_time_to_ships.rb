class AddFinishTimeToShips < ActiveRecord::Migration
  def change
    add_column :ships, :finish_time, :integer
  end
end

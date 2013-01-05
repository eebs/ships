class RemoveShipFromRuns < ActiveRecord::Migration
  def up
    remove_column :runs, :ship
  end

  def down
    add_column :runs, :ship, :string
  end
end

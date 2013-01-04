class AddShipIdToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :ship_id, :string
  end
end

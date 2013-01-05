class ChangeShipIdToInteger < ActiveRecord::Migration
  def change
    change_column :runs, :ship_id, :integer
  end
end

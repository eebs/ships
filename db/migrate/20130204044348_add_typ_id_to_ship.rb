class AddTypIdToShip < ActiveRecord::Migration
  def change
    add_column :ships, :type_id, :string
  end
end

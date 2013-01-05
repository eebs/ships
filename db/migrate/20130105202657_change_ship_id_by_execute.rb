class ChangeShipIdByExecute < ActiveRecord::Migration
  def up
    execute 'ALTER TABLE runs ALTER COLUMN ship_id TYPE integer USING CAST(ship_id AS INTEGER)'
  end

  def down
    change_column :runs, :ship_id, :string
  end
end

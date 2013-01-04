class ChangeStatusName < ActiveRecord::Migration
  def change
    rename_column :runs, :status, :status_id
  end
end

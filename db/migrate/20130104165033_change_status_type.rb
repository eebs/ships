class ChangeStatusType < ActiveRecord::Migration
  def change
    change_column :runs, :status, :integer
  end
end

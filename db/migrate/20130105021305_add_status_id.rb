class AddStatusId < ActiveRecord::Migration
  def up
  	remove_column :runs, :status
  	add_column :runs, :status_id, :integer
  end
end

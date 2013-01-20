class AddAdminToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :admin, :boolean, :default => false
  end
end

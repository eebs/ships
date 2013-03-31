class RenameMessageTypeToType < ActiveRecord::Migration
  def change
    add_column :messages, :type, :string
    remove_column :messages, :message_type
  end
end

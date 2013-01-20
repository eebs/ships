class ClearNotifications < ActiveRecord::Migration
  def up
    drop_table :notifications

    create_table :notifications do |t|
      t.integer :character_id
      t.integer :message_id
      t.datetime :read_at

      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

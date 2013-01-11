class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :message_id
      t.datetime :read_at

      t.timestamps
    end
  end
end

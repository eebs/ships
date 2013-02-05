class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :character_id
      t.integer :run_id

      t.timestamps
    end
  end
end

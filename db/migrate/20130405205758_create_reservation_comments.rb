class CreateReservationComments < ActiveRecord::Migration
  def change
    create_table :reservation_comments do |t|
      t.integer :character_id
      t.integer :reservation_id
      t.text :body

      t.timestamps
    end
  end
end

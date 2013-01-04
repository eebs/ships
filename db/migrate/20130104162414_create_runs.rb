class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.datetime :next_due
      t.string :ship
      t.integer :ship_number
      t.string :status
      t.float :sell_price
      t.datetime :start_date
      t.datetime :sell_date
      t.text :notes

      t.timestamps
    end
  end
end

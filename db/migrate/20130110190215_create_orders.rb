class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :orderID
      t.string :charID
      t.string :stationID
      t.string :volEntered
      t.string :volRemaining
      t.string :minVolume
      t.string :orderState
      t.string :typeID
      t.string :range
      t.string :duration
      t.string :price
      t.string :bid

      t.timestamps
    end
  end
end

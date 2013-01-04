class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name
      t.string :ship_type

      t.timestamps
    end
  end
end

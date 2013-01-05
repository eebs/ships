class LoadAll < ActiveRecord::Migration
  def change
    create_table "runs", :force => true do |t|
      t.string   "next_due"
      t.integer  "ship_number"
      t.float    "sell_price"
      t.string   "start_date"
      t.string   "sell_date"
      t.text     "notes"
      t.datetime "created_at",                 :null => false
      t.datetime "updated_at",                 :null => false
      t.integer  "ship_id",     :limit => 255
      t.integer  "status_id"
    end

    create_table "ships", :force => true do |t|
      t.string   "name"
      t.string   "ship_type"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "statuses", :force => true do |t|
      t.string   "name"
      t.string   "color"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end

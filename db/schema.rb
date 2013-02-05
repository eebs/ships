# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130205033403) do

  create_table "characters", :force => true do |t|
    t.string   "encrypted_password",  :default => "",    :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "characterid"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin",               :default => false
  end

  add_index "characters", ["name"], :name => "index_characters_on_name", :unique => true

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "character_id"
    t.integer  "message_id"
    t.datetime "read_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "orderID"
    t.string   "charID"
    t.string   "stationID"
    t.string   "volEntered"
    t.string   "volRemaining"
    t.string   "minVolume"
    t.string   "orderState"
    t.string   "typeID"
    t.string   "range"
    t.string   "duration"
    t.string   "price"
    t.string   "bid"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "character_id"
    t.integer  "run_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

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
    t.string   "type_id"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

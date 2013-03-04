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

ActiveRecord::Schema.define(:version => 20130303234943) do

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

  create_table "jobs", :force => true do |t|
    t.string   "jobID"
    t.string   "assemblyLineID"
    t.string   "containerID"
    t.string   "installedItemID"
    t.string   "installedItemLocationID"
    t.string   "installedItemQuantity"
    t.string   "installedItemProductivityLevel"
    t.string   "installedItemMaterialLevel"
    t.string   "installedItemLicensedProductionRunsRemaining"
    t.string   "outputLocationID"
    t.string   "installerID"
    t.string   "runs"
    t.string   "licensedProductionRuns"
    t.string   "installedInSolarSystemID"
    t.string   "containerLocationID"
    t.string   "materialMultiplier"
    t.string   "charMaterialMultiplier"
    t.string   "timeMultiplier"
    t.string   "charTimeMultiplier"
    t.string   "installedItemTypeID"
    t.string   "outputTypeID"
    t.string   "containerTypeID"
    t.string   "installedItemCopy"
    t.string   "completed"
    t.string   "completedSuccessfully"
    t.string   "installedItemFlag"
    t.string   "outputFlag"
    t.string   "activityID"
    t.string   "completedStatus"
    t.string   "installTime"
    t.string   "beginProductionTime"
    t.string   "endProductionTime"
    t.string   "pauseProductionTime"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "jobs", ["jobID"], :name => "index_jobs_on_jobID", :unique => true

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
    t.datetime "next_due"
    t.integer  "ship_number"
    t.float    "sell_price"
    t.datetime "start_date"
    t.datetime "sell_date"
    t.text     "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "ship_id"
    t.integer  "status_id"
    t.datetime "finish_date"
  end

  create_table "ships", :force => true do |t|
    t.string   "name"
    t.string   "ship_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "type_id"
    t.integer  "finish_time"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

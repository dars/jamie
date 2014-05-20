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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140520071707) do

  create_table "Device", primary_key: "ID", force: true do |t|
    t.integer "ModelID",                      default: 0,  null: false
    t.string  "SerialNumber",      limit: 11, default: "", null: false
    t.string  "FolderNameLocal",   limit: 11, default: ""
    t.string  "FolderNameOnline",  limit: 11, default: ""
    t.string  "FolderNameUpdate",  limit: 11, default: ""
    t.integer "IsCanLogin",                   default: 0,  null: false
    t.integer "SongServerGroupID",            default: 0,  null: false
    t.integer "ProducersID",                  default: 0,  null: false
    t.integer "PublisherID",                  default: 0,  null: false
    t.integer "AgentsID",                     default: 0,  null: false
    t.integer "ConsumerID",                   default: 0,  null: false
    t.text    "Note"
    t.string  "cus_name",          limit: 50
    t.string  "cus_uuid",          limit: 20
    t.string  "cus_birthday",      limit: 10
    t.string  "cus_tel",           limit: 20
    t.string  "cus_apply_at",      limit: 20
    t.string  "cus_address"
    t.integer "dealer_id"
  end

  create_table "Log", primary_key: "ID", force: true do |t|
    t.integer "CmdType",                                   null: false
    t.integer "cmdTypeClient",                             null: false
    t.integer "ClientType",                                null: false
    t.string  "DeviceSN",          limit: 16, default: "", null: false
    t.string  "SongServerAccount", limit: 16, default: "", null: false
    t.string  "SongNumber",        limit: 10, default: "", null: false
    t.integer "SongFileType",                              null: false
    t.string  "RemoteIP",          limit: 15, default: "", null: false
    t.string  "DateTime",          limit: 20, default: "", null: false
    t.string  "Message",           limit: 20, default: "", null: false
    t.string  "otherTitle",        limit: 20, default: "", null: false
  end

  create_table "Model", primary_key: "ID", force: true do |t|
    t.string  "ModelName",         limit: 50, default: "", null: false
    t.string  "FolderNameLocal",   limit: 50
    t.string  "FolderNameOnline",  limit: 50
    t.string  "FolderNameUpdate",  limit: 50
    t.integer "SongServerGroupID",                         null: false
    t.integer "ProducersID",                               null: false
    t.integer "PublisherID",                               null: false
    t.integer "AgentsID",                                  null: false
    t.text    "Note"
  end

  create_table "SingerTable", primary_key: "ID", force: true do |t|
    t.integer "Location"
    t.string  "SingerNameT"
    t.string  "NameIndexT"
    t.integer "StrokeT"
    t.string  "SingerNameC"
    t.string  "NameIndexC"
    t.integer "StrokeC"
    t.integer "Country"
    t.integer "Class"
  end

  create_table "SongTable", force: true do |t|
    t.integer "Album"
    t.integer "Location"
    t.string  "SongNumber"
    t.string  "SongNameT"
    t.string  "NameIndexT"
    t.integer "StrokeT"
    t.string  "SongNameC"
    t.string  "NameIndexC"
    t.integer "StrokeC"
    t.integer "SingerIndex1"
    t.integer "SingerIndex2"
    t.integer "Type"
    t.integer "Count"
    t.integer "MyFavorite"
    t.integer "Phylum"
    t.integer "Class"
    t.integer "Groups"
    t.integer "Party"
    t.integer "Data"
    t.integer "ExStartTime"
    t.integer "ExAllTime"
    t.integer "LightID"
    t.integer "LogoID"
    t.string  "MV"
    t.string  "Teaching"
    t.integer "licensee_id"
  end

  create_table "countries", force: true do |t|
    t.string "name"
  end

  create_table "dealers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kinds", force: true do |t|
    t.string "name"
  end

  create_table "licensees", force: true do |t|
    t.string "name"
  end

  create_table "phylum", force: true do |t|
    t.string "name"
  end

  create_table "taxonomies", force: true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.integer "identity"
  end

  create_table "transations", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "type"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "sign_in_count",   default: 0
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "license_id"
    t.string   "session_token"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end

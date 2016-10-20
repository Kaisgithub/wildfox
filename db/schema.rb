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

ActiveRecord::Schema.define(version: 20160928061608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "component_states", force: :cascade do |t|
    t.integer  "component_type_id"
    t.string   "state_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "component_types", force: :cascade do |t|
    t.string   "typename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.integer  "component_type_id"
    t.integer  "component_state_id"
    t.string   "describe"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "contents", force: :cascade do |t|
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genre_styles", force: :cascade do |t|
    t.integer  "genre_id"
    t.string   "height"
    t.string   "width"
    t.string   "x"
    t.string   "y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.integer  "content_id"
    t.string   "number"
    t.string   "typename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kinds", force: :cascade do |t|
    t.string   "kindname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "body"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "modes", force: :cascade do |t|
    t.string   "modename"
    t.integer  "kind_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "modes", ["kind_id"], name: "index_modes_on_kind_id", using: :btree

  create_table "package_styles", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "height"
    t.string   "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "category"
    t.string   "desc"
    t.string   "number"
    t.string   "typename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parts", force: :cascade do |t|
    t.jsonb    "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "modes", "kinds"
end

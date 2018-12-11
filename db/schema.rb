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

ActiveRecord::Schema.define(version: 2018_12_10_001555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "calories"
    t.date "occurred_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "heights", force: :cascade do |t|
    t.bigint "user_id"
    t.float "measurement"
    t.date "measured_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_heights_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.date "birthday"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weights", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "measurement"
    t.date "measured_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weights_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "calories"
    t.date "occurred_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "foods", "users"
  add_foreign_key "heights", "users"
  add_foreign_key "weights", "users"
  add_foreign_key "workouts", "users"
end

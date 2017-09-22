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

ActiveRecord::Schema.define(version: 20170920190620) do

  create_table "flights", force: :cascade do |t|
    t.integer "rank"
    t.string "destination"
    t.string "airline"
    t.datetime "departureDateTime"
    t.datetime "returnDateTime"
    t.integer "fare"
  end

  create_table "user_flights", force: :cascade do |t|
    t.integer "user_id"
    t.integer "flight_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "fullname"
    t.string "email"
    t.string "username"
    t.string "password_digest"
  end

end

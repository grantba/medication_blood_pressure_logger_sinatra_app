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

ActiveRecord::Schema.define(version: 2021_02_25_234147) do

  create_table "blood_pressure_readings", force: :cascade do |t|
    t.string "date"
    t.string "time"
    t.string "systolic_reading"
    t.string "diastolic_reading"
    t.string "pulse"
    t.text "device_used"
    t.string "site_used"
    t.text "notes"
    t.integer "user_id"
    t.integer "family_member_id"
  end

  create_table "family_members", force: :cascade do |t|
    t.string "name"
    t.string "date_of_birth"
    t.text "address"
    t.string "phone_number"
    t.string "email"
    t.integer "user_id"
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.string "dose"
    t.string "form"
    t.string "route"
    t.string "time_to_be_taken"
    t.string "category"
    t.string "prescription_number"
    t.string "date_filled"
    t.string "refill_date"
    t.string "discard_or_expiration_date"
    t.text "side_effects"
    t.text "notes"
    t.integer "user_id"
    t.integer "family_member_id"
    t.integer "physician_id"
    t.integer "pharmacy_id"
  end

  create_table "pharmacies", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phone_number"
    t.string "website"
    t.text "notes"
    t.integer "user_id"
    t.integer "family_member_id"
  end

  create_table "physicians", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phone_number"
    t.string "website"
    t.text "notes"
    t.integer "user_id"
    t.integer "family_member_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "date_of_birth"
    t.text "address"
    t.string "phone_number"
    t.string "email"
    t.string "username"
    t.string "password_digest"
  end

end

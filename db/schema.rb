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

ActiveRecord::Schema.define(version: 6) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id"
    t.bigint "user_id"
    t.date "date"
    t.integer "status"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.boolean "active"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id"
    t.bigint "user_id"
    t.datetime "start"
    t.datetime "end"
    t.string "title"
    t.string "type"
    t.string "status"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_events_on_doctor_id"
    t.index ["patient_id"], name: "index_events_on_patient_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "financial_records", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id"
    t.bigint "user_id"
    t.bigint "appointment_id"
    t.integer "status", default: 0
    t.string "title"
    t.integer "amount"
    t.date "date"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_financial_records_on_appointment_id"
    t.index ["doctor_id"], name: "index_financial_records_on_doctor_id"
    t.index ["patient_id"], name: "index_financial_records_on_patient_id"
    t.index ["user_id"], name: "index_financial_records_on_user_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", null: false
    t.date "birthday"
    t.string "sex"
    t.string "phone"
    t.string "cell_phone"
    t.string "email"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active"
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "users"
  add_foreign_key "events", "doctors"
  add_foreign_key "events", "patients"
  add_foreign_key "events", "users"
  add_foreign_key "financial_records", "appointments"
  add_foreign_key "financial_records", "doctors"
  add_foreign_key "financial_records", "patients"
  add_foreign_key "financial_records", "users"
end

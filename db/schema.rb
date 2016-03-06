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

ActiveRecord::Schema.define(version: 20160212080236) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "attendances", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "event_id"
    t.integer  "round"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendances", ["event_id"], name: "index_attendances_on_event_id"
  add_index "attendances", ["team_id"], name: "index_attendances_on_team_id"

  create_table "coordinators", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "rollnumber"
    t.integer  "event_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "coordinators", ["email"], name: "index_coordinators_on_email", unique: true
  add_index "coordinators", ["reset_password_token"], name: "index_coordinators_on_reset_password_token", unique: true

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participant_attendances", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "participant_id"
    t.integer  "event_id"
    t.integer  "round"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "participant_attendances", ["event_id"], name: "index_participant_attendances_on_event_id"
  add_index "participant_attendances", ["participant_id"], name: "index_participant_attendances_on_participant_id"
  add_index "participant_attendances", ["team_id"], name: "index_participant_attendances_on_team_id"

  create_table "participants", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "college"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reg_desks", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "rollnumber"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "event_id"
  end

  add_index "reg_desks", ["email"], name: "index_reg_desks_on_email", unique: true
  add_index "reg_desks", ["event_id"], name: "index_reg_desks_on_event_id"
  add_index "reg_desks", ["reset_password_token"], name: "index_reg_desks_on_reset_password_token", unique: true

  create_table "results", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "event_id"
    t.integer  "round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_details", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "team_details", ["participant_id"], name: "index_team_details_on_participant_id"
  add_index "team_details", ["team_id"], name: "index_team_details_on_team_id"

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

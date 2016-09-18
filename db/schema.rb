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

ActiveRecord::Schema.define(version: 20160918141033) do

  create_table "logins", force: :cascade do |t|
    t.string   "country_code"
    t.integer  "salt_id"
    t.integer  "provider_id"
    t.string   "provider_code"
    t.string   "provider_name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_success_at"
    t.datetime "next_refresh_possible_at"
    t.text     "last_attempt"
    t.text     "holder_info"
    t.boolean  "daily_refresh"
    t.integer  "customer_id"
    t.string   "secret"
  end

  add_index "logins", ["customer_id"], name: "index_logins_on_customer_id"
  add_index "logins", ["salt_id"], name: "index_logins_on_salt_id", unique: true

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "salt_id"
    t.string   "salt_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["salt_id"], name: "index_users_on_salt_id", unique: true

end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_07_165127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_attendees", force: :cascade do |t|
    t.string "discord_id"
    t.string "name"
    t.string "discriminator"
    t.string "from_server"
    t.string "from_channel"
    t.string "guild"
    t.string "role_1"
    t.string "role_2"
    t.string "role_3"
    t.bigint "event_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.index ["discord_id", "event_id"], name: "index_event_attendees_on_discord_id_and_event_id", unique: true
    t.index ["event_id"], name: "index_event_attendees_on_event_id"
    t.index ["user_id"], name: "index_event_attendees_on_user_id"
  end

  create_table "event_parties", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.jsonb "members"
    t.jsonb "party_format"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_parties_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "activity"
    t.string "name"
    t.datetime "starts_at", precision: 6
    t.integer "tanks_needed"
    t.integer "healers_needed"
    t.integer "melee_dps_needed"
    t.integer "ranged_dps_needed"
    t.integer "mages_needed"
    t.string "event_details"
    t.string "event_image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "location"
    t.datetime "published_at", precision: 6
    t.jsonb "discord_messages"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "discord_avatar"
    t.string "discord_username"
    t.string "discord_discriminator"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "guild_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "event_attendees", "events"
  add_foreign_key "event_attendees", "users"
  add_foreign_key "event_parties", "events"
end

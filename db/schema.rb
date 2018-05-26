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

ActiveRecord::Schema.define(version: 20180526144137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.integer "profile_id"
    t.string "aim"
    t.integer "rater_age_min"
    t.integer "rater_age_max"
    t.string "rater_gender"
    t.integer "date_duration"
    t.datetime "auction_end"
    t.datetime "video_date_start"
    t.decimal "bid_step"
    t.decimal "start_bid"
    t.string "video_preview"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "winner_id"
    t.boolean "videodate_ended", default: false
    t.datetime "videodate_end_time"
    t.integer "videodate_past_time", default: 0
  end

  create_table "balances", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "balance", default: "0.0", null: false
    t.decimal "unavailable_balance", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bids", force: :cascade do |t|
    t.integer "auction_id"
    t.integer "profile_id"
    t.decimal "bid_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "country"
    t.string "country_code"
    t.string "city"
    t.string "administrative_area_level_2"
    t.string "administrative_area_level_1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "author_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id", "receiver_id"], name: "index_conversations_on_author_id_and_receiver_id", unique: true
    t.index ["author_id"], name: "index_conversations_on_author_id"
    t.index ["receiver_id"], name: "index_conversations_on_receiver_id"
  end

  create_table "etz_investments", force: :cascade do |t|
    t.string "wallet"
    t.datetime "time"
    t.decimal "etz"
    t.decimal "rdt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gifts", force: :cascade do |t|
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "kycs", force: :cascade do |t|
    t.string "wallet"
    t.integer "user_id"
    t.string "firstname"
    t.string "lastname"
    t.string "country"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "state"
    t.string "province"
    t.string "postal_code"
    t.string "identity_photo"
    t.string "address_photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_personal_messages_on_conversation_id"
    t.index ["user_id"], name: "index_personal_messages_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "profile_id"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.boolean "hide_surname"
    t.string "nickname"
    t.string "avatar"
    t.date "dob"
    t.boolean "hide_dob"
    t.string "gender"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "city_id"
    t.integer "crop_x"
    t.integer "crop_y"
    t.integer "crop_w"
    t.integer "crop_h"
    t.string "languages", array: true
    t.string "timezone"
    t.index ["languages"], name: "index_profiles_on_languages", using: :gin
  end

  create_table "sent_gifts", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.integer "gift_id"
    t.string "message"
    t.boolean "anonim", default: false, null: false
    t.boolean "hide", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_sent_gifts_on_receiver_id"
    t.index ["sender_id"], name: "index_sent_gifts_on_sender_id"
  end

  create_table "site_settings", force: :cascade do |t|
    t.string "etz_raized"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "referred_by"
    t.string "eth_wallet"
    t.boolean "superadmin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "identities", "users"
  add_foreign_key "personal_messages", "conversations"
  add_foreign_key "personal_messages", "users"
end

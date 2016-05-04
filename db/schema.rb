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

ActiveRecord::Schema.define(version: 20160504093847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees_lists", force: :cascade do |t|
    t.integer "attendable_id"
    t.string  "attendable_type"
    t.boolean "open",            default: false, null: false
    t.integer "minimum",         default: 7,     null: false
    t.integer "maximum",         default: 11,    null: false
  end

  add_index "attendees_lists", ["attendable_type", "attendable_id"], name: "index_attendees_lists_on_attendable_type_and_attendable_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",   limit: 255
    t.string   "address",       limit: 255, null: false
    t.string   "name",                      null: false
    t.integer  "club_team_id"
    t.integer  "rival_team_id"
    t.boolean  "home",                      null: false
    t.datetime "datetime",                  null: false
    t.string   "type",                      null: false
    t.string   "slug",                      null: false
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "forum_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "forum_thread_id"
    t.text     "comment"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "forum_posts", ["forum_thread_id"], name: "index_forum_posts_on_forum_thread_id", using: :btree
  add_index "forum_posts", ["user_id"], name: "index_forum_posts_on_user_id", using: :btree

  create_table "forum_threads", force: :cascade do |t|
    t.string   "topic"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "forum_threads", ["user_id"], name: "index_forum_threads_on_user_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.boolean  "internal",   default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer "user_id",                            null: false
    t.string  "nickname",                           null: false
    t.string  "first_name"
    t.string  "last_name"
    t.date    "date_of_birth"
    t.string  "place_of_birth"
    t.string  "street"
    t.string  "zipcode"
    t.string  "city"
    t.string  "phone1"
    t.string  "phone2"
    t.string  "club_email"
    t.string  "membership_number"
    t.date    "member_since"
    t.date    "member_until"
    t.boolean "player_pass"
    t.string  "player_pass_number"
    t.date    "eligible_to_play_since"
    t.integer "jersey_number"
    t.string  "jersey_name"
    t.integer "status",                 default: 0
  end

  add_index "players", ["jersey_number"], name: "index_players_on_jersey_number", unique: true, using: :btree
  add_index "players", ["user_id"], name: "index_players_on_user_id", unique: true, using: :btree

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "status",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["event_id", "user_id"], name: "index_replies_on_event_id_and_user_id", unique: true, using: :btree
  add_index "replies", ["event_id"], name: "index_replies_on_event_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "event_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_final_score",        limit: 2
    t.integer  "rival_final_score",       limit: 2
    t.integer  "club_half_time_score",    limit: 2
    t.integer  "rival_half_time_score",   limit: 2
    t.integer  "result"
    t.string   "annotation"
    t.integer  "captain_id"
    t.integer  "corners_club"
    t.integer  "corners_rival"
    t.integer  "goalkeeper_id"
    t.integer  "incident"
    t.integer  "most_valuable_player_id"
    t.integer  "points"
    t.integer  "possession"
    t.boolean  "referee"
    t.string   "referee_description"
    t.string   "referee_name"
    t.integer  "reporter_id"
    t.integer  "turf"
    t.integer  "weather"
  end

  add_index "reports", ["event_id"], name: "index_reports_on_event_id", unique: true, using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.boolean  "club"
    t.boolean  "player_pass_needed", default: false, null: false
    t.boolean  "current_season",     default: false, null: false
  end

  add_index "teams", ["name"], name: "index_teams_on_name", unique: true, using: :btree

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "alias"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.boolean  "legacy_password"
    t.boolean  "admin",                              default: false, null: false
    t.boolean  "player_pass",                        default: false, null: false
    t.boolean  "player",                             default: false, null: false
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "users"
  add_foreign_key "forum_posts", "forum_threads"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "forum_threads", "users"
  add_foreign_key "user_profiles", "users"
end

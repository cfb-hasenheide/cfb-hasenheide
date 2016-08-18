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

ActiveRecord::Schema.define(version: 20160817181339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street",           null: false
    t.string   "zipcode",          null: false
    t.string   "city",             null: false
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  end

  create_table "attendance_lists", force: :cascade do |t|
    t.string  "attendable_type"
    t.integer "attendable_id"
    t.boolean "open",            default: false, null: false
    t.integer "minimum",         default: 7,     null: false
    t.integer "maximum",         default: 11,    null: false
    t.index ["attendable_type", "attendable_id"], name: "index_attendance_lists_on_attendable_type_and_attendable_id", using: :btree
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "attendance_list_id"
    t.integer  "player_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attendance_list_id", "player_id"], name: "index_attendances_on_attendance_list_id_and_player_id", unique: true, using: :btree
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "club_email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id"], name: "index_contacts_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.datetime "datetime",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "address",       null: false
    t.string   "home_team"
    t.string   "away_team"
    t.string   "name",          null: false
    t.integer  "club_team_id"
    t.integer  "rival_team_id"
    t.boolean  "home",          null: false
    t.string   "type",          null: false
    t.string   "slug",          null: false
    t.index ["slug"], name: "index_events_on_slug", unique: true, using: :btree
  end

  create_table "forum_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "forum_thread_id"
    t.text     "comment"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["forum_thread_id"], name: "index_forum_posts_on_forum_thread_id", using: :btree
    t.index ["user_id"], name: "index_forum_posts_on_user_id", using: :btree
  end

  create_table "forum_threads", force: :cascade do |t|
    t.string   "topic"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forum_threads_on_user_id", using: :btree
  end

  create_table "functions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "assumed_at"
    t.datetime "vacated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_functions_on_role_id", using: :btree
    t.index ["user_id"], name: "index_functions_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

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
    t.string  "membership_number"
    t.date    "member_since"
    t.date    "member_until"
    t.boolean "player_pass"
    t.string  "player_pass_number"
    t.date    "eligible_to_play_since"
    t.integer "jersey_number"
    t.string  "jersey_name"
    t.integer "status",                 default: 0
    t.string  "slug"
    t.string  "avatar"
    t.index ["jersey_number"], name: "index_players_on_jersey_number", unique: true, using: :btree
    t.index ["slug"], name: "index_players_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_players_on_user_id", unique: true, using: :btree
  end

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
    t.index ["event_id"], name: "index_reports_on_event_id", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.boolean  "club"
    t.boolean  "player_pass_needed", default: false, null: false
    t.boolean  "current_season",     default: false, null: false
    t.index ["name"], name: "index_teams_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.boolean  "legacy_password"
    t.boolean  "admin",                  default: false, null: false
    t.index ["admin"], name: "index_users_on_admin", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "forum_posts", "forum_threads"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "forum_threads", "users"
  add_foreign_key "functions", "roles"
  add_foreign_key "functions", "users"
end

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

ActiveRecord::Schema.define(version: 2018_02_13_200835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "street", null: false
    t.string "zipcode", null: false
    t.string "city", null: false
    t.string "addressable_type"
    t.integer "addressable_id"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "attendance_lists", id: :serial, force: :cascade do |t|
    t.integer "attendable_id"
    t.string "attendable_type"
    t.boolean "open", default: false, null: false
    t.integer "minimum", default: 7, null: false
    t.integer "maximum", default: 11, null: false
    t.index ["attendable_type", "attendable_id"], name: "index_attendance_lists_on_attendable_type_and_attendable_id"
  end

  create_table "attendances", id: :serial, force: :cascade do |t|
    t.integer "attendance_list_id"
    t.integer "player_id"
    t.integer "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attendance_list_id", "player_id"], name: "index_attendances_on_attendance_list_id_and_player_id", unique: true
  end

  create_table "bootsy_image_galleries", id: :serial, force: :cascade do |t|
    t.integer "bootsy_resource_id"
    t.string "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", id: :serial, force: :cascade do |t|
    t.string "image_file"
    t.integer "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", id: :serial, force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.text "content", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "phone1"
    t.string "phone2"
    t.string "club_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.index ["member_id"], name: "index_contacts_on_member_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.datetime "datetime", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "description"
    t.string "address", null: false
    t.string "home_team"
    t.string "away_team"
    t.string "name", null: false
    t.integer "club_team_id"
    t.integer "rival_team_id"
    t.boolean "home", null: false
    t.string "type", null: false
    t.string "slug", null: false
    t.boolean "public", default: false, null: false
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "forum_posts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "forum_thread_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_thread_id"], name: "index_forum_posts_on_forum_thread_id"
    t.index ["user_id"], name: "index_forum_posts_on_user_id"
  end

  create_table "forum_threads", id: :serial, force: :cascade do |t|
    t.string "topic"
    t.text "comment"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forum_threads_on_user_id"
  end

  create_table "functions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.date "assumed_on"
    t.date "vacated_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_functions_on_role_id"
    t.index ["user_id"], name: "index_functions_on_user_id"
  end

  create_table "goals", id: :serial, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "minute", null: false
    t.integer "extra_time"
    t.integer "club_score", null: false
    t.integer "rival_score", null: false
    t.boolean "club", null: false
    t.integer "scorer_id"
    t.integer "provider_id"
    t.text "comment"
    t.integer "reporter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_goals_on_event_id"
    t.index ["provider_id"], name: "index_goals_on_provider_id"
    t.index ["reporter_id"], name: "index_goals_on_reporter_id"
    t.index ["scorer_id"], name: "index_goals_on_scorer_id"
  end

  create_table "homepage_headers", id: :serial, force: :cascade do |t|
    t.boolean "active", default: false, null: false
    t.string "background_image"
    t.string "heading", null: false
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "background_position_y", default: 0, null: false
    t.string "color", default: "#ffffff", null: false
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "identifier"
    t.date "member_since"
    t.date "member_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.date "date_of_birth"
    t.string "place_of_birth"
    t.string "player_ideal"
    t.string "personal_moment"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "content", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "news", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.boolean "internal", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.string "nickname", null: false
    t.boolean "player_pass"
    t.string "player_pass_number"
    t.date "eligible_to_play_since"
    t.integer "jersey_number"
    t.string "jersey_name"
    t.integer "status", default: 0
    t.string "slug"
    t.string "avatar"
    t.integer "member_id"
    t.index ["jersey_number"], name: "index_players_on_jersey_number", unique: true
    t.index ["member_id"], name: "index_players_on_member_id"
    t.index ["slug"], name: "index_players_on_slug", unique: true
  end

  create_table "players_teams", id: false, force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.index ["player_id", "team_id"], name: "index_players_teams_on_player_id_and_team_id", unique: true
    t.index ["team_id", "player_id"], name: "index_players_teams_on_team_id_and_player_id", unique: true
  end

  create_table "players_trainings", id: false, force: :cascade do |t|
    t.integer "training_id", null: false
    t.integer "player_id", null: false
    t.index ["player_id", "training_id"], name: "index_players_trainings_on_player_id_and_training_id"
    t.index ["training_id", "player_id"], name: "index_players_trainings_on_training_id_and_player_id"
  end

  create_table "reports", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "club_final_score", limit: 2
    t.integer "rival_final_score", limit: 2
    t.integer "club_half_time_score", limit: 2
    t.integer "rival_half_time_score", limit: 2
    t.integer "result"
    t.string "annotation"
    t.integer "captain_id"
    t.integer "corners_club"
    t.integer "corners_rival"
    t.integer "goalkeeper_id"
    t.integer "incident"
    t.integer "most_valuable_player_id"
    t.integer "points"
    t.integer "possession"
    t.boolean "referee"
    t.string "referee_description"
    t.string "referee_name"
    t.integer "reporter_id"
    t.integer "turf"
    t.integer "weather"
    t.index ["event_id"], name: "index_reports_on_event_id", unique: true
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "description"
    t.boolean "club"
    t.boolean "player_pass_needed", default: false, null: false
    t.boolean "current_season", default: false, null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "trainings", id: :serial, force: :cascade do |t|
    t.date "date", null: false
    t.integer "additional_count", default: 0, null: false
    t.string "additional_info"
    t.index ["date"], name: "index_trainings_on_date", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "username"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.integer "invitations_count", default: 0
    t.boolean "legacy_password"
    t.boolean "admin", default: false, null: false
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "contacts", "members"
  add_foreign_key "forum_posts", "forum_threads"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "forum_threads", "users"
  add_foreign_key "functions", "roles"
  add_foreign_key "functions", "users"
  add_foreign_key "goals", "events"
  add_foreign_key "goals", "players", column: "provider_id"
  add_foreign_key "goals", "players", column: "reporter_id"
  add_foreign_key "goals", "players", column: "scorer_id"
  add_foreign_key "members", "users"
  add_foreign_key "players", "members"
end

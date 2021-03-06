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

ActiveRecord::Schema.define(version: 20150225053656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_alarms", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "schedule_id"
    t.integer  "user_id"
    t.datetime "scheduled_for",                null: false
    t.boolean  "manual",                       null: false
    t.boolean  "active",        default: true, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "attendance_alarms", ["course_id"], name: "index_attendance_alarms_on_course_id", using: :btree
  add_index "attendance_alarms", ["schedule_id"], name: "index_attendance_alarms_on_schedule_id", using: :btree
  add_index "attendance_alarms", ["user_id"], name: "index_attendance_alarms_on_user_id", using: :btree

  create_table "attendances", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.boolean  "auto",       default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "attendances", ["course_id"], name: "index_attendances_on_course_id", using: :btree
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id", using: :btree

  create_table "attendances_users", id: false, force: :cascade do |t|
    t.integer  "attendance_id", null: false
    t.integer  "user_id",       null: false
    t.string   "state",         null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "attendances_users", ["attendance_id"], name: "index_attendances_users_on_attendance_id", using: :btree
  add_index "attendances_users", ["user_id"], name: "index_attendances_users_on_user_id", using: :btree

  create_table "clicker_choices", force: :cascade do |t|
    t.integer  "clicker_id"
    t.integer  "user_id"
    t.string   "choice",     default: "text", null: false
    t.string   "message",    default: "",     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "clicker_choices", ["clicker_id"], name: "index_clicker_choices_on_clicker_id", using: :btree
  add_index "clicker_choices", ["user_id"], name: "index_clicker_choices_on_user_id", using: :btree

  create_table "clickers", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "type",        default: "mult4",     null: false
    t.string   "message",     default: "",          null: false
    t.boolean  "saved",       default: false,       null: false
    t.integer  "time_length", default: 45,          null: false
    t.boolean  "cheating",    default: true,        null: false
    t.string   "privacy",     default: "professor", null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "clickers", ["course_id"], name: "index_clickers_on_course_id", using: :btree
  add_index "clickers", ["user_id"], name: "index_clickers_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "message",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name",                           null: false
    t.string   "instructor_name",                null: false
    t.string   "code",                           null: false
    t.string   "information"
    t.boolean  "open",            default: true, null: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "courses", ["school_id"], name: "index_courses_on_school_id", using: :btree

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer  "course_id",  null: false
    t.integer  "user_id",    null: false
    t.string   "state",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses_users", ["course_id"], name: "index_courses_users_on_course_id", using: :btree
  add_index "courses_users", ["user_id"], name: "index_courses_users_on_user_id", using: :btree

  create_table "curiouses", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "title",                   null: false
    t.string   "message",    default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "curiouses", ["course_id"], name: "index_curiouses_on_course_id", using: :btree
  add_index "curiouses", ["user_id"], name: "index_curiouses_on_user_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "platform",         null: false
    t.string   "uuid"
    t.string   "mac_address"
    t.string   "notification_key"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree
  add_index "devices", ["uuid"], name: "index_devices_on_uuid", using: :btree

  create_table "followers", force: :cascade do |t|
    t.integer  "followable_id"
    t.string   "followable_type"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "followers", ["user_id"], name: "index_followers_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "notice_targets", force: :cascade do |t|
    t.integer  "notice_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notice_targets", ["notice_id"], name: "index_notice_targets_on_notice_id", using: :btree
  add_index "notice_targets", ["user_id"], name: "index_notice_targets_on_user_id", using: :btree

  create_table "notices", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.boolean  "targeted",   default: false, null: false
    t.string   "message",    default: "",    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "notices", ["course_id"], name: "index_notices_on_course_id", using: :btree
  add_index "notices", ["user_id"], name: "index_notices_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "seen",            default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "notifications", ["course_id"], name: "index_notifications_on_course_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "preferences", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "clicker",    default: true,  null: false
    t.boolean  "attendance", default: true,  null: false
    t.boolean  "curious",    default: false, null: false
    t.boolean  "notice",     default: true,  null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "following",  default: true,  null: false
  end

  add_index "preferences", ["user_id"], name: "index_preferences_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "day_of_week", null: false
    t.string   "time",        null: false
    t.string   "timezone",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schedules", ["course_id"], name: "index_schedules_on_course_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "classification", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "schools_users", id: false, force: :cascade do |t|
    t.integer  "school_id",                        null: false
    t.integer  "user_id",                          null: false
    t.string   "identity"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "is_supervisor",    default: false, null: false
    t.boolean  "is_student",       default: false, null: false
    t.boolean  "is_administrator", default: false, null: false
  end

  add_index "schools_users", ["school_id"], name: "index_schools_users_on_school_id", using: :btree
  add_index "schools_users", ["user_id"], name: "index_schools_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                              default: "",   null: false
    t.string   "name",                                              null: false
    t.string   "locale",                             default: "en", null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "encrypted_password",     limit: 128, default: "",   null: false
    t.string   "provider"
    t.string   "uid"
    t.integer  "failed_attempts",                    default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end

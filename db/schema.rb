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

ActiveRecord::Schema.define(version: 20150108052849) do

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
    t.integer  "attendance_id",             null: false
    t.integer  "user_id",                   null: false
    t.string   "state",         limit: 255, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "attendances_users", ["attendance_id"], name: "index_attendances_users_on_attendance_id", using: :btree
  add_index "attendances_users", ["user_id"], name: "index_attendances_users_on_user_id", using: :btree

  create_table "clicker_choices", force: :cascade do |t|
    t.integer  "clicker_id"
    t.integer  "user_id"
    t.string   "choice",     limit: 255, default: "text", null: false
    t.string   "message",    limit: 255, default: "",     null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "clicker_choices", ["clicker_id"], name: "index_clicker_choices_on_clicker_id", using: :btree
  add_index "clicker_choices", ["user_id"], name: "index_clicker_choices_on_user_id", using: :btree

  create_table "clickers", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "type",        limit: 255, default: "mult4",     null: false
    t.string   "message",     limit: 255, default: "",          null: false
    t.boolean  "saved",                   default: false,       null: false
    t.integer  "time_length",             default: 45,          null: false
    t.boolean  "cheating",                default: true,        null: false
    t.string   "privacy",     limit: 255, default: "professor", null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "clickers", ["course_id"], name: "index_clickers_on_course_id", using: :btree
  add_index "clickers", ["user_id"], name: "index_clickers_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.integer  "user_id"
    t.string   "message",          limit: 255, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name",            limit: 255,                null: false
    t.string   "instructor_name", limit: 255,                null: false
    t.string   "code",            limit: 255,                null: false
    t.string   "information",     limit: 255
    t.boolean  "open",                        default: true, null: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "courses", ["school_id"], name: "index_courses_on_school_id", using: :btree

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer  "course_id",              null: false
    t.integer  "user_id",                null: false
    t.string   "state",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "courses_users", ["course_id"], name: "index_courses_users_on_course_id", using: :btree
  add_index "courses_users", ["user_id"], name: "index_courses_users_on_user_id", using: :btree

  create_table "curious", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "title",      limit: 255, default: "", null: false
    t.string   "message",    limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "curious", ["course_id"], name: "index_curious_on_course_id", using: :btree
  add_index "curious", ["user_id"], name: "index_curious_on_user_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "platform",         limit: 255, null: false
    t.string   "uuid",             limit: 255
    t.string   "mac_address",      limit: 255
    t.string   "notification_key", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree
  add_index "devices", ["uuid"], name: "index_devices_on_uuid", using: :btree

  create_table "followers", force: :cascade do |t|
    t.integer  "followable_id"
    t.string   "followable_type", limit: 255
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "followers", ["user_id"], name: "index_followers_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type", limit: 255
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
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
    t.boolean  "targeted",               default: false, null: false
    t.string   "message",    limit: 255, default: "",    null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "notices", ["course_id"], name: "index_notices_on_course_id", using: :btree
  add_index "notices", ["user_id"], name: "index_notices_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "notifiable_id"
    t.string   "notifiable_type", limit: 255
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "seen",                        default: false, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "notifications", ["course_id"], name: "index_notifications_on_course_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "preferences", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "clicker",    default: true,  null: false
    t.boolean  "attendance", default: true,  null: false
    t.boolean  "notice",     default: true,  null: false
    t.boolean  "curious",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "following",  default: true,  null: false
  end

  add_index "preferences", ["user_id"], name: "index_preferences_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "day_of_week", limit: 255, null: false
    t.string   "time",        limit: 255, null: false
    t.string   "timezone",    limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "schedules", ["course_id"], name: "index_schedules_on_course_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",           limit: 255, null: false
    t.string   "classification", limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "schools_users", id: false, force: :cascade do |t|
    t.integer  "school_id",                                    null: false
    t.integer  "user_id",                                      null: false
    t.string   "identity",         limit: 255,                 null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "is_supervisor",                default: false, null: false
    t.boolean  "is_student",                   default: false, null: false
    t.boolean  "is_administrator",             default: false, null: false
  end

  add_index "schools_users", ["school_id"], name: "index_schools_users_on_school_id", using: :btree
  add_index "schools_users", ["user_id"], name: "index_schools_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255,                null: false
    t.string   "password_digest", limit: 255
    t.string   "name",            limit: 255,                null: false
    t.string   "locale",          limit: 255, default: "en", null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end

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

ActiveRecord::Schema.define(version: 20141129191438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_alarms", force: true do |t|
    t.integer  "course_id"
    t.integer  "schedule_id"
    t.integer  "user_id"
    t.datetime "scheduled_for",                null: false
    t.boolean  "manual",                       null: false
    t.boolean  "active",        default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendance_alarms", ["course_id"], name: "index_attendance_alarms_on_course_id", using: :btree
  add_index "attendance_alarms", ["schedule_id"], name: "index_attendance_alarms_on_schedule_id", using: :btree
  add_index "attendance_alarms", ["user_id"], name: "index_attendance_alarms_on_user_id", using: :btree

  create_table "attendances", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.boolean  "auto",       default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "attendances", ["course_id"], name: "index_attendances_on_course_id", using: :btree
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id", using: :btree

  create_table "attendances_users", id: false, force: true do |t|
    t.integer  "attendance_id", null: false
    t.integer  "user_id",       null: false
    t.string   "state",         null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "attendances_users", ["attendance_id"], name: "index_attendances_users_on_attendance_id", using: :btree
  add_index "attendances_users", ["user_id"], name: "index_attendances_users_on_user_id", using: :btree

  create_table "clicker_choices", force: true do |t|
    t.integer  "clicker_id"
    t.integer  "user_id"
    t.string   "choice",     default: "text", null: false
    t.string   "message",    default: "",     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "clicker_choices", ["clicker_id"], name: "index_clicker_choices_on_clicker_id", using: :btree
  add_index "clicker_choices", ["user_id"], name: "index_clicker_choices_on_user_id", using: :btree

  create_table "clickers", force: true do |t|
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

  create_table "courses", force: true do |t|
    t.integer  "school_id"
    t.string   "name",            null: false
    t.string   "instructor_name", null: false
    t.string   "code",            null: false
    t.string   "information"
    t.boolean  "open",            null: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "courses", ["school_id"], name: "index_courses_on_school_id", using: :btree

  create_table "courses_users", id: false, force: true do |t|
    t.integer "course_id", null: false
    t.integer "user_id",   null: false
    t.string  "state",     null: false
  end

  add_index "courses_users", ["course_id"], name: "index_courses_users_on_course_id", using: :btree
  add_index "courses_users", ["user_id"], name: "index_courses_users_on_user_id", using: :btree

  create_table "devices", force: true do |t|
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

  create_table "schedules", force: true do |t|
    t.integer  "course_id"
    t.string   "day_of_week", null: false
    t.string   "time",        null: false
    t.string   "timezone",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["course_id"], name: "index_schedules_on_course_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name",           null: false
    t.string   "classification", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "schools_users", id: false, force: true do |t|
    t.integer "school_id", null: false
    t.integer "user_id",   null: false
    t.string  "identity",  null: false
    t.string  "state",     null: false
  end

  add_index "schools_users", ["school_id"], name: "index_schools_users_on_school_id", using: :btree
  add_index "schools_users", ["user_id"], name: "index_schools_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                          null: false
    t.string   "password_digest"
    t.string   "name",                           null: false
    t.string   "locale",          default: "en", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end

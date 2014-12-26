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

ActiveRecord::Schema.define(version: 20141226122447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_alarms", force: true do |t|
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


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

ActiveRecord::Schema.define(version: 20141221135042) do

  create_table "students", force: true do |t|
    t.string   "stu_no"
    t.string   "stu_name"
    t.integer  "grade"
    t.integer  "gender"
    t.string   "address"
    t.string   "tel"
    t.string   "mobile"
    t.string   "email"
    t.integer  "supervisor1"
    t.integer  "supervisor2"
    t.boolean  "is_graduated"
    t.string   "job_organization"
    t.string   "job_title"
    t.string   "job_industry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "name_c"
    t.string   "name_e"
    t.string   "office_c"
    t.string   "office_e"
    t.text     "domain_c"
    t.text     "domain_e"
    t.string   "degree_c"
    t.string   "degree_e"
    t.string   "title_c"
    t.string   "title_e"
    t.integer  "title_priority"
    t.boolean  "is_chair"
    t.string   "email"
    t.string   "tel"
    t.string   "extension"
    t.integer  "employ_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theses", force: true do |t|
    t.string   "name_c"
    t.string   "name_e"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conference"
  end

end

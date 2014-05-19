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

ActiveRecord::Schema.define(version: 20140518135708) do

  create_table "cells", force: true do |t|
    t.integer  "row_id"
    t.integer  "line"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "features", force: true do |t|
    t.string   "name"
    t.integer  "line"
    t.string   "json_id",     null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "features", ["json_id"], name: "features_json_id"
  add_index "features", ["name"], name: "features_name"

  create_table "rows", force: true do |t|
    t.integer  "sceanrios_step_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scenario_tags", id: false, force: true do |t|
    t.integer  "scenario_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenario_tags", ["scenario_id"], name: "scenario_tags_scenario_id"
  add_index "scenario_tags", ["tag_id"], name: "scenario_tags_tag_id"

  create_table "scenarios", force: true do |t|
    t.string   "name"
    t.integer  "line"
    t.string   "json_id",     null: false
    t.text     "description"
    t.integer  "feature_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenarios", ["name"], name: "scenarios_name"

  create_table "scenarios_steps", force: true do |t|
    t.integer  "scenario_id"
    t.integer  "step_id"
    t.string   "keyword"
    t.integer  "line"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenarios_steps", ["scenario_id"], name: "scenarios_steps_scenario_id"
  add_index "scenarios_steps", ["step_id"], name: "scenarios_steps_step_id"

  create_table "steps", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steps", ["name"], name: "steps_name"

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "tags_name"

end

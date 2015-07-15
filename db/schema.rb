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

ActiveRecord::Schema.define(version: 20150715180242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badge_nominations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.integer  "level_nominated"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "status"
    t.integer  "nominator_id"
    t.string   "level_granted"
    t.text     "evidence"
    t.date     "effective_date"
  end

  create_table "badge_set_entries", force: :cascade do |t|
    t.integer  "badge_set_id"
    t.integer  "badge_id"
    t.integer  "level"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "badge_sets", force: :cascade do |t|
    t.integer  "proposer_id"
    t.string   "name"
    t.integer  "comp_tier_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "proposer_id"
    t.string   "status"
    t.date     "proposal_date"
    t.integer  "levels"
    t.text     "level_1"
    t.text     "level_2"
    t.text     "level_3"
    t.text     "level_4"
    t.text     "level_5"
    t.text     "level_6"
    t.text     "level_7"
    t.text     "level_8"
    t.text     "level_9"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "focus"
    t.text     "feedback"
    t.text     "mechanism"
    t.date     "acceptance_date"
  end

  create_table "comp_tiers", force: :cascade do |t|
    t.string   "name"
    t.integer  "monthly_draw"
    t.integer  "fixed_draw"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nomination_votes", force: :cascade do |t|
    t.integer  "badge_nomination_id"
    t.integer  "validator_id"
    t.integer  "level"
    t.text     "comment"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "role"
    t.string   "short"
    t.boolean  "bootstrapper?", default: false
    t.string   "email"
  end

end

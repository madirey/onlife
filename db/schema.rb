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

ActiveRecord::Schema.define(version: 20140512002553) do

  create_table "player_year", force: true do |t|
    t.integer "player_id"
    t.integer "year",            null: false
    t.string  "league",          null: false
    t.string  "team",            null: false
    t.integer "games",           null: false
    t.integer "at_bats"
    t.integer "runs"
    t.integer "hits"
    t.integer "doubles"
    t.integer "triples"
    t.integer "home_runs"
    t.integer "rbis"
    t.integer "stolen_bases"
    t.integer "caught_stealing"
  end

  create_table "players", id: false, force: true do |t|
    t.string  "player_id",  null: false
    t.integer "birth_year"
    t.string  "first_name"
    t.string  "last_name"
  end

end

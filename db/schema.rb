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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120521055522) do

  create_table "fouls", :force => true do |t|
    t.string   "symbol"
    t.string   "description"
    t.integer  "foul_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "game_fouls", :force => true do |t|
    t.integer  "game_member_id"
    t.integer  "occurrence_time"
    t.integer  "foul_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "game_goals", :force => true do |t|
    t.integer  "game_member_id"
    t.integer  "occurrence_time"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "game_members", :force => true do |t|
    t.integer  "member_id"
    t.integer  "starting_status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "game_team_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "uniform_number"
    t.integer  "position_id"
  end

  create_table "game_player_substitutions", :force => true do |t|
    t.integer  "game_member_id"
    t.integer  "occurrence_time"
    t.integer  "in_or_out"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "game_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "home_or_away"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "game_id"
    t.string   "name"
  end

  create_table "games", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "the_date"
    t.time     "start_time"
    t.time     "end_time"
  end

  create_table "members", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "player_number"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "member_type",    :default => 0, :null => false
    t.integer  "uniform_number"
    t.integer  "position_id"
    t.datetime "deleted_at"
    t.date     "birth_day"
  end

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "team_members", :force => true do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
  end

end

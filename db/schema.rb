# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_13_145507) do
  create_table "exp_rewards", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gears", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "hp"
    t.integer "atk"
    t.integer "def"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "asset_key"
    t.integer "level"
  end

  create_table "gold_rewards", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "itemable_type"
    t.integer "itemable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monster_rewards", force: :cascade do |t|
    t.string "rewardable_type", null: false
    t.integer "rewardable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "monster_id", null: false
    t.index ["monster_id"], name: "index_monster_rewards_on_monster_id"
    t.index ["rewardable_type", "rewardable_id"], name: "index_monster_rewards_on_rewardable"
  end

  create_table "monsters", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "atk"
    t.integer "def"
    t.integer "hp"
    t.string "asset_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", null: false
    t.integer "player_id"
    t.index ["player_id"], name: "index_monsters_on_player_id"
  end

  create_table "player_items", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "player_id", null: false
    t.boolean "equipped"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pos"
    t.index ["item_id"], name: "index_player_items_on_item_id"
    t.index ["player_id"], name: "index_player_items_on_player_id"
  end

  create_table "player_quests", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "quest_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_quests_on_player_id"
    t.index ["quest_id"], name: "index_player_quests_on_quest_id"
  end

  create_table "player_tasks", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "task_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_tasks_on_player_id"
    t.index ["task_id"], name: "index_player_tasks_on_task_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.integer "level"
    t.integer "hp"
    t.integer "atk"
    t.integer "def"
    t.integer "gold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exp", default: 0
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "quest_rewards", force: :cascade do |t|
    t.integer "quest_id", null: false
    t.string "rewardable_type", null: false
    t.integer "rewardable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quest_id"], name: "index_quest_rewards_on_quest_id"
    t.index ["rewardable_type", "rewardable_id"], name: "index_quest_rewards_on_rewardable"
  end

  create_table "quests", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "quest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.index ["quest_id"], name: "index_tasks_on_quest_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "monster_rewards", "monsters"
  add_foreign_key "monsters", "players"
  add_foreign_key "player_items", "items"
  add_foreign_key "player_items", "players"
  add_foreign_key "player_quests", "players"
  add_foreign_key "player_quests", "quests"
  add_foreign_key "player_tasks", "players"
  add_foreign_key "player_tasks", "tasks"
  add_foreign_key "players", "users"
  add_foreign_key "quest_rewards", "quests"
  add_foreign_key "sessions", "users"
  add_foreign_key "tasks", "quests"
end

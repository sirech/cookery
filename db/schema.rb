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

ActiveRecord::Schema.define(version: 20130713111159) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_recipes", force: true do |t|
    t.integer "recipe_id"
    t.integer "category_id"
  end

  add_index "categories_recipes", ["category_id"], name: "index_categories_recipes_on_category_id"
  add_index "categories_recipes", ["recipe_id"], name: "index_categories_recipes_on_recipe_id"

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "found_at"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "caption"
    t.integer  "recipe_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quantities", force: true do |t|
    t.string   "unit"
    t.integer  "amount",        default: 0
    t.integer  "step_id"
    t.integer  "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quantities", ["ingredient_id"], name: "index_quantities_on_ingredient_id"
  add_index "quantities", ["step_id"], name: "index_quantities_on_step_id"

  create_table "recipes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "difficulty"
  end

  create_table "steps", force: true do |t|
    t.string   "name"
    t.integer  "recipe_id"
    t.integer  "duration",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.integer  "position"
  end

  add_index "steps", ["recipe_id"], name: "index_steps_on_recipe_id"

  create_table "videos", force: true do |t|
    t.integer "recipe_id"
    t.string  "url"
  end

  add_index "videos", ["recipe_id"], name: "index_videos_on_recipe_id"

end

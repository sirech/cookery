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

ActiveRecord::Schema.define(version: 20130701192415) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_recipes", force: true do |t|
    t.integer "recipe_id"
    t.integer "category_id"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "found_at"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients_steps", force: true do |t|
    t.integer "step_id"
    t.integer "ingredient_id"
  end

  create_table "recipes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "difficulty"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "step_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "step_hierarchies", ["ancestor_id", "descendant_id"], name: "index_step_hierarchies_on_ancestor_id_and_descendant_id", unique: true
  add_index "step_hierarchies", ["descendant_id"], name: "index_step_hierarchies_on_descendant_id"

  create_table "steps", force: true do |t|
    t.string   "name"
    t.integer  "recipe_id"
    t.integer  "duration"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steps", ["recipe_id"], name: "index_steps_on_recipe_id"

end

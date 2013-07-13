# -*- coding: utf-8 -*-
class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :name
      t.references :recipe, index: true
      t.integer :duration, default: 0
      t.integer :parent_id

      t.timestamps
    end

    create_table :ingredients_steps do |t|
      t.belongs_to :step
      t.belongs_to :ingredient
    end

    create_table :step_hierarchies, id: false do |t|
      t.integer  :ancestor_id, null: false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, null: false # ID of the target tag
      t.integer  :generations, null: false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    # For "all progeny of…" selects:
    add_index :step_hierarchies, [:ancestor_id, :descendant_id], unique: true

    # For "all ancestors of…" selects
    add_index :step_hierarchies, [:descendant_id]
  end
end

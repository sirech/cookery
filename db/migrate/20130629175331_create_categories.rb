class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :categories_recipes do |t|
      t.belongs_to :recipe
      t.belongs_to :category
    end

  end
end

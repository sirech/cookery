class AddVideosToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :videos, :text
  end
end

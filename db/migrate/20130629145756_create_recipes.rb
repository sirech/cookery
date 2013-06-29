class CreateRecipes < ActiveRecord::Migration

  def change
    create_table :recipes do |t|
      t.timestamps

      t.string :name
      t.string :difficulty
    end
  end
end

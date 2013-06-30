class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :found_at
      t.text :notes

      t.timestamps
    end
  end
end

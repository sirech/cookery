class CreatePictures < ActiveRecord::Migration
  def change
    remove_attachment :recipes, :picture

    create_table :pictures do |t|
      t.string :caption
      t.integer :recipe_id
      t.attachment :photo

      t.timestamps
    end
  end
end

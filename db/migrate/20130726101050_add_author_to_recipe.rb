class AddAuthorToRecipe < ActiveRecord::Migration
  def change
    change_table :recipes do |t|
      t.belongs_to :user, index: true
    end
  end
end

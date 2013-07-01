class AddAttachmentPictureToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :recipes, :picture
  end
end

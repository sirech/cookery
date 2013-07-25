class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.belongs_to :recipe, index: true
      t.string :url
    end
  end
end

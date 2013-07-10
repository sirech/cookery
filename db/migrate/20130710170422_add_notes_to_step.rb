class AddNotesToStep < ActiveRecord::Migration
  def change
    add_column :steps, :notes, :text
  end
end

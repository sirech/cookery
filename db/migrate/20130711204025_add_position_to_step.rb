class AddPositionToStep < ActiveRecord::Migration
  def change
    add_column :steps, :position, :integer

    # Remove remants of closure_tree
    drop_table :step_hierarchies
    remove_column :steps, :parent_id
  end
end

class RemovePositionFromSteps < ActiveRecord::Migration
  def change
    remove_column :steps, :position, :integer
  end
end

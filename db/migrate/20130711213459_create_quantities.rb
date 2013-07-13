class CreateQuantities < ActiveRecord::Migration
  def change
    drop_table :ingredients_steps

    create_table :quantities do |t|
      t.string :unit
      t.integer :amount, default: 0
      t.references :step, index: true
      t.references :ingredient, index: true

      t.timestamps
    end
  end
end

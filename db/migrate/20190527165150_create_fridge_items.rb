class CreateFridgeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :fridge_items do |t|
      t.references :fridge, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end

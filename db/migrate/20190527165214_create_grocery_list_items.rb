class CreateGroceryListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery__list_items do |t|
      t.references :grocery_list, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.integer :quantity
      t.boolean :checked

      t.timestamps
    end
  end
end

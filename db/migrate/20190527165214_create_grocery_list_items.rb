class CreateGroceryListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_list_items do |t|
      t.references :user, foreign_key: true

      t.references :ingredient, foreign_key: true
      t.integer :quantity
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end

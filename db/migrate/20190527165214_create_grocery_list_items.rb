class CreateGroceryListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_list_items do |t|
<<<<<<< HEAD
      t.references :user, foreign_key: true
=======
      t.references :grocery_list, foreign_key: true
>>>>>>> master
      t.references :ingredient, foreign_key: true
      t.integer :quantity
      t.boolean :checked

      t.timestamps
    end
  end
end

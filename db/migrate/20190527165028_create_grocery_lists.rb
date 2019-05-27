class CreateGroceryLists < ActiveRecord::Migration[5.2]
  def change
    create_table :grocery_lists do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class PutIntegerBackToRecipeItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipe_items, :quantity, :float
    add_column :recipe_items, :quantity, :integer
  end
end

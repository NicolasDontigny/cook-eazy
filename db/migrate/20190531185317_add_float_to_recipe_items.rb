class AddFloatToRecipeItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipe_items, :quantity, :integer
    add_column :recipe_items, :quantity, :float
  end
end

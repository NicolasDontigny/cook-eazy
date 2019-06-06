class ChangeDoneRecipesToCookedRecipes < ActiveRecord::Migration[5.2]
  def change
    rename_table :done_recipes, :cooked_recipes
  end
end

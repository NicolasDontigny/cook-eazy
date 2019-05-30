class RemoveRatingFromRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :rating
  end
end

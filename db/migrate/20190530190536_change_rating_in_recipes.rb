class ChangeRatingInRecipes < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :rating, :float
  end
end

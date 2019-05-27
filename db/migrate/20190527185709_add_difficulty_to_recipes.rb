class AddDifficultyToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :difficulty, :string
  end
end

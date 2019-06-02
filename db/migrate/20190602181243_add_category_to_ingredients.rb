class AddCategoryToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :category, :string
  end
end

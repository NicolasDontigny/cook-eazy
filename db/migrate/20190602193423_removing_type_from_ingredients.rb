class RemovingTypeFromIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :type, :string
  end
end

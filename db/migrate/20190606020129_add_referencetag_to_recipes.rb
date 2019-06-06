class AddReferencetagToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_reference :tag_items, :recipe, index: true
    add_foreign_key :tag_items, :recipes

  end
end

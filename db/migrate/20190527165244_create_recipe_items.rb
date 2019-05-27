class CreateRecipeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_items do |t|
      t.references :recipe, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end

class CreateDoneRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :done_recipes do |t|
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end

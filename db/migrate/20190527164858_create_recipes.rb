class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :prep_time
      t.integer :cook_time
      t.integer :servings
      t.string :steps
      t.integer :rating
      t.string :photo

      t.timestamps
    end
  end
end

class CreateFavoriteItems < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_items do |t|
      t.references :favorite, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end

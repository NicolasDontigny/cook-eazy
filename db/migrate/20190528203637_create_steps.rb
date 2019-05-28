class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.text :content
      t.integer :order
      t.references :recipe

      t.timestamps
    end
  end
end

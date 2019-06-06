class CreateTagItems < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_items do |t|
      t.references :tag
      t.references :recipe

      t.timestamps
    end
  end
end

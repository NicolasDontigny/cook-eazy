class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_items, dependent: :destroy
  has_many :ingredients, through: :recipe_items

  has_many :cooking_list_items
  has_many :users, through: :cooking_list_items
end

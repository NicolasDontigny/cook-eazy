class Ingredient < ApplicationRecord
  has_many :fridge_items, dependent: :destroy
  has_many :grocery_list_items, dependent: :destroy
  has_many :recipe_items, dependent: :destroy

  has_many :users, through: :fridge_items
  has_many :users, through: :grocery_list_items
  has_many :users, through: :recipe_items
end

class Ingredient < ApplicationRecord
  has_many :fridge_items, dependent: :destroy
  has_many :grocery_list_items, dependent: :destroy
  has_many :recipe_items, dependent: :destroy

  has_many :fridges, through: :fridge_items
  has_many :grocery_lists, through: :grocery__listitems
  has_many :recipes, through: :recipe_items
end

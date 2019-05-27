class GroceryList < ApplicationRecord
  belongs_to :user
  has_many :grocery_list_items, dependent: :destroy
  has_many :ingredients, through: :grocery_list_items
end

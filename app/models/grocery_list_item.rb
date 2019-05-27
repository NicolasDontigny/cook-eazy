class GroceryListItem < ApplicationRecord
  belongs_to :fridge
  belongs_to :ingredient
end

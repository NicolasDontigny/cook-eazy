class FridgeItem < ApplicationRecord
  belongs_to :fridge
  belongs_to :ingredient
end

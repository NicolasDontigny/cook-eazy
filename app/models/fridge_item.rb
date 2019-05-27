class FridgeItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
end

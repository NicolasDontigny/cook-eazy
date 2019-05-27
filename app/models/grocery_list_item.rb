class GroceryListItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient

  validates :quantity, presence: true, numericality: { only_integer: true }
end

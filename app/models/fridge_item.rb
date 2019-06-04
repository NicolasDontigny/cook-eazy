class FridgeItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient

  validates :quantity, presence: true, allow_blank: false, numericality: { only_integer: true, greater_than: 0 }
end

class Fridge < ApplicationRecord
  belongs_to :user
  has_many :fridge_items, dependent: :destroy
  has_many :ingredients, through: :fridge_items
end

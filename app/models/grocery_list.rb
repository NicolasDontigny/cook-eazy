class Grocery < ApplicationRecord
  belongs_to :user
  has_many :grocery_list_items
  has_many :ingredients, through: :grocery_list_items
end

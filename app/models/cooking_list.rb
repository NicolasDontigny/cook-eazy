class CookingList < ApplicationRecord
  belongs_to :user
  has_many :cooking_list_items
  has_many :recipes, through: :cooking_list_items
end

class CookingList < ApplicationRecord
  belongs_to :user
  has_many :cooking_list_items, dependent: :destroy
  has_many :recipes, through: :cooking_list_items
end

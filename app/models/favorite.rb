class Favorite < ApplicationRecord
  belongs_to :user
  has_many :favorite_items
  has_many :recipes, through: :favorite_items
end

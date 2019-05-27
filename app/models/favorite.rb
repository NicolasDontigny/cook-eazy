class Favorite < ApplicationRecord
  belongs_to :user
  has_many :favorite_items, dependent: :destroy
  has_many :recipes, through: :favorite_items
end

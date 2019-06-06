class Tag < ApplicationRecord
  has_many :tag_items, dependent: :destroy
  has_many :recipes, through: :tag_items
end

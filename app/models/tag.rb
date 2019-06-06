class Tag < ApplicationRecord
  has_many :tag_items, dependent: :destroy
end

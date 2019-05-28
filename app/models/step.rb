class Step < ApplicationRecord
  belongs_to :recipe

  validates :content, presence: true, allow_blank: false
  validates :order, presence: true, allow_blank: false, numericality: { only_integer: true }
end

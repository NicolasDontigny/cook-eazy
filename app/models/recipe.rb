class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_items, dependent: :destroy
  has_many :ingredients, through: :recipe_items
  has_many :reviews, dependent: :destroy
  has_many :steps, dependent: :destroy

  has_many :cooking_list_items
  has_many :users, through: :cooking_list_items

  # validates :steps, length: { minimum: 1 }

  def update_ratings!
    all_ratings = []
    reviews.each do |review|
      all_ratings << review.rating
    end
    self.rating = all_ratings.reduce(:+) / all_ratings.size.to_f
  end
end

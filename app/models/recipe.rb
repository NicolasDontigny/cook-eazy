class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_items, dependent: :destroy
  has_many :ingredients, through: :recipe_items
  has_many :reviews, dependent: :destroy
  has_many :steps, dependent: :destroy

  has_many :wishlist_items, dependent: :destroy
  has_many :users, through: :wishlist_items

  accepts_nested_attributes_for :steps

  # validates :steps, length: { minimum: 1 }

  def missing_ingredients(fridge_items)
    missing_ingredients = []

    recipe_items.each do |recipe_item|
      if fridge_items.none? { |item| item.ingredient == recipe_item.ingredient }
        missing_ingredients << recipe_item
      end
    end

    return missing_ingredients
  end

  def insufficient_ingredients(fridge_items)
    insufficient_ingredients = []

    recipe_items.each do |recipe_item|
      if fridge_items.any? { |item| item.ingredient == recipe_item.ingredient && item.quantity < recipe_item.quantity }
        insufficient_ingredients << recipe_item
      end
    end
    return insufficient_ingredients
  end

  def matching_ingredients(fridge_items)
    matching_ingredients = []

    recipe_items.each do |recipe_item|
      if fridge_items.any? { |item| item.ingredient == recipe_item.ingredient && item.quantity >= recipe_item.quantity }
        matching_ingredients << recipe_item
      end
    end
    return matching_ingredients
  end

  def how_many_ingredients_to_buy(fridge_items)
    missing_ingredients(fridge_items).count + insufficient_ingredients(fridge_items).count
  end

  def update_ratings!
    all_ratings = []
    reviews.each do |review|
      all_ratings << review.rating
    end
    self.rating = all_ratings.reduce(:+) / all_ratings.size.to_f
  end
end

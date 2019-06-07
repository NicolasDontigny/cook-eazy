class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_items, dependent: :destroy
  has_many :ingredients, through: :recipe_items
  has_many :tag_items, dependent: :destroy
  has_many :tags, through: :tag_items
  has_many :reviews, dependent: :destroy
  has_many :steps, dependent: :destroy

  has_many :wishlist_items, dependent: :destroy
  has_many :cooked_recipes, dependent: :destroy
  has_many :users, through: :wishlist_items

  accepts_nested_attributes_for :steps, :recipe_items

  include PgSearch
  pg_search_scope :search_by_name,
                  against: %i[name],
                  associated_against: {
                    ingredients: %i[name],
                    steps: %i[content]
                  },
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }

  def missing_ingredients(user)
    # missing_ingredients = []
    # fridge_items = FridgeItem.where(user: user)

    # recipe_items.each do |recipe_item|
    #   if fridge_items.none? { |item| item.ingredient == recipe_item.ingredient }
    #     missing_ingredients << recipe_item
    #   elsif fridge_items.any? { |item| item.ingredient == recipe_item.ingredient && item.quantity < recipe_item.quantity }
    #     missing_ingredients << recipe_item
    #   end
    # end

    # return missing_ingredients
    user_ingredients = user.fridge_items
    user_ingredient_ids = user_ingredients.pluck(:ingredient_id)
    recipe_items.select do |item|
      !(user_ingredient_ids.include? item.ingredient_id) || item.quantity > user_ingredients.find_by(ingredient: item.ingredient).quantity
    end
  end

  def matching_ingredients(user)
    user_ingredients = user.fridge_items
    user_ingredient_ids = user_ingredients.pluck(:ingredient_id)
    recipe_items.where(ingredient_id: user_ingredient_ids).select do |item|
      item.quantity <= user_ingredients.find_by(ingredient: item.ingredient).quantity
    end
  end

  def how_many_ingredients_to_buy(user)
    missing_ingredients(user).count
  end

  def rating
    all_ratings = []
    reviews.each do |review|
      all_ratings << review.rating
    end
    rating = ((all_ratings.reduce(:+) / all_ratings.size.to_f) * 2).round / 2.0

    return rating
  end
end

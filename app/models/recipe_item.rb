class RecipeItem < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def how_many_missing
    # Try to find this recipeItem ingredient in my fridge
    fridge_item = ingredient.fridge_items.to_a.find { |fi| fi.ingredient_id == ingredient.id }

    # If I have this same ingredient in my fridge, AND I don't have enough
    if fridge_item && fridge_item.quantity < quantity
      # Find the missing quantity
      return quantity - fridge_item.quantity
    elsif !fridge_item
      return quantity
    else
      return 0
    end
  end
end

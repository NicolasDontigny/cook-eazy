class CookedRecipesController < ApplicationController
  def index
    @cooked_recipes = CookedRecipe.where(user: current_user)

    @reviewed_recipes = @cooked_recipes.select { |cooked_recipe| cooked_recipe.recipe.reviews.any? { |review| review.user == current_user } }
    @unreviewed_recipes = @cooked_recipes.select { |cooked_recipe| cooked_recipe.recipe.reviews.none? { |review| review.user == current_user } }
  end
end

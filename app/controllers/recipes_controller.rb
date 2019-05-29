class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show popup]
  before_action :set_recipe, only: %i[popup done!]
  before_action :set_fridge_items, only: %i[index popup]

  def index
    @recipes = Recipe.all.sort do |recipe1, recipe2|
      if recipe1.how_many_ingredients_to_buy(@fridge_items) == recipe2.how_many_ingredients_to_buy(@fridge_items)
        recipe2.matching_ingredients(@fridge_items).count <=> recipe1.matching_ingredients(@fridge_items).count
      else
        recipe1.how_many_ingredients_to_buy(@fridge_items) <=> recipe2.how_many_ingredients_to_buy(@fridge_items)
      end
    end
  end

  def popup
    respond_to do |format|
      format.html { redirect_to recipe_path(@recipe) }
      format.js { render 'show_popup.js.erb', recipe: @recipe }
    end
  end

  def steps
  end

  def done!
    @ingredients = @recipe.ingredients
    empty_fridge(@ingredients)
  end

  def show
    @recipe = Recipe.find(params[:id])
    # @recipe = Recipe.find(5)
    @reviews = @recipe.reviews
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_fridge_items
    @fridge_items = FridgeItem.where(user: current_user)
  end
end

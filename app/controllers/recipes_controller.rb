class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show popup]
  before_action :set_recipe, only: %i[popup]

  def index
    @recipes = Recipe.all
    @fridge_items = FridgeItem.where(user: current_user)
  end

  def popup
    respond_to do |format|
      format.html { redirect_to recipe_path(@recipe) }
      format.js { render 'show_popup.js.erb' }
    end
  end

  def steps
  end

  def show
    @recipe = Recipe.find(params[:id])
    # @recipe = Recipe.find(5)
    @reviews = @recipe.reviews
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end

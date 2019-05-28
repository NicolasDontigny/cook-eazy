class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_recipe, only: %i[popup]

  def index
    @recipes = Recipe.all
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
    # @recipe = Recipe.find(params[:id])
    @recipe = Recipe.find(24)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end

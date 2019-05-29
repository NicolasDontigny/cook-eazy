class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show popup]
  before_action :set_recipe, only: %i[popup done!]

  def index
    @recipes = Recipe.all
    @fridge_items = FridgeItem.where(user: current_user)
  end

  def index_owner
    @current_user = current_user
    @recipes = Recipe.where(user: current_user)
  end

  def popup
    respond_to do |format|
      format.html { redirect_to recipe_path(@recipe) }
      format.js { render 'show_popup.js.erb', recipe: @recipe }
    end
  end

  def new
    @recipe = Recipe.new
    @recipe.steps.build
    @step_number = 1
  end

  def create
    new_recipe = Recipe.new(params_permit)
    new_recipe.user = current_user

    new_recipe.save!

    # flash[:just_created] = "Created \"#{new_recipe.name}\" Successfully!"

    redirect_to my_recipes_path
  end

  def steps
  end

  def done!
    @ingredients = @recipe.ingredients
    empty_fridge(@ingredients)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @reviews = @recipe.reviews
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def params_permit
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :servings, steps_attributes: [:order, :content])
  end
end

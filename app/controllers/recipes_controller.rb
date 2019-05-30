class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show popup]
  before_action :set_recipe, only: %i[popup done!]
  before_action :set_fridge_items, only: %i[index popup]

  def index
    # Sort all existing recipes
    @recipes = Recipe.all.sort do |recipe1, recipe2|
      # For recipes that have the same number of missing ingredients
      # Sort them by the highest number of matching ingredients
      if recipe1.how_many_ingredients_to_buy(@fridge_items) == recipe2.how_many_ingredients_to_buy(@fridge_items)
        recipe2.matching_ingredients(@fridge_items).count <=> recipe1.matching_ingredients(@fridge_items).count
      # Otherwise, sort them by the least missing ingredients
      else
        recipe1.how_many_ingredients_to_buy(@fridge_items) <=> recipe2.how_many_ingredients_to_buy(@fridge_items)
      end
    end

    # Give all the recipes in the current user's wishlist
    @wishlist_recipes = []
    WishlistItem.where(user: current_user).each do |wishlist_item|
      @wishlist_recipes << wishlist_item.recipe
    end

    @wishlist_recipes.sort do |recipe1, recipe2|
      # For recipes that have the same number of missing ingredients
      # Sort them by the highest number of matching ingredients
      if recipe1.how_many_ingredients_to_buy(@fridge_items) == recipe2.how_many_ingredients_to_buy(@fridge_items)
        recipe2.matching_ingredients(@fridge_items).count <=> recipe1.matching_ingredients(@fridge_items).count
      # Otherwise, sort them by the least missing ingredients
      else
        recipe1.how_many_ingredients_to_buy(@fridge_items) <=> recipe2.how_many_ingredients_to_buy(@fridge_items)
      end
    end
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

    # params[recipe_items].each do |recipe_item|
    #   new_recipe_item = RecipeItem.new(ingredient_id: recipe_item[ingredient_id], quantity: recipe_item[quantity])
    #   new_recipe_item.recipe = new_recipe
    #   new_recipe_item.save!
    # end

    flash[:notice] = "Created \"#{new_recipe.name}\" Successfully!"

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
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :servings, :photo, steps_attributes: [:order, :content])
  end

  def set_fridge_items
    @fridge_items = FridgeItem.where(user: current_user)
  end
end

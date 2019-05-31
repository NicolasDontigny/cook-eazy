class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show popup]
  before_action :set_recipe, only: %i[popup done! steps]
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
    @recipe.recipe_items.build
    @step_number = 1
    @ingredient_number = 1
    @ingredients = Ingredient.all.map do |ingredient|
      {
        id: ingredient.id,
        name: ingredient.name
      }
    end

  end

  def create
    new_recipe = Recipe.new(params_permit)
    new_recipe.user = current_user
    new_recipe.save!

    flash[:notice] = "Created \"#{new_recipe.name}\" Successfully!"

    redirect_to my_recipes_path
  end

  def steps
    @steps = @recipe.steps.order(order: :asc)
    @length = @steps.length - 1

  end

  def done!
    @ingredients = @recipe.ingredients
    empty_fridge(@ingredients)
  end

  def show
    @fridge_items = FridgeItem.where(user: current_user)
    @recipe = Recipe.find(params[:id])
    @reviews = @recipe.reviews
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def params_permit
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :servings, :photo, :ingredient_ids, steps_attributes: [:order, :content], recipe_items_attributes: [:ingredient_id, :quantity])
  end

  def set_fridge_items
    @fridge_items = FridgeItem.where(user: current_user)
  end
end

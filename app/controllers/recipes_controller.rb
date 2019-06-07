class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show popup]
  before_action :set_recipe, only: %i[popup done! steps]
  before_action :set_fridge_items, only: %i[index popup]

  def index
    # @fridge_items = FridgeItem.where(user: current_user)
    # Sort all existing recipes
    @search_filters = true

    if params[:query].present?
      @query = params[:query]
      session[:query] = params[:query]
    else
      session[:query] = nil if params[:time].blank? && params[:category].blank?
      @query = session[:query]
    end

    if params[:max_time].present? && params[:category].present?
      @max_time = params[:max_time]
      @category = params[:category]
      session[:max_time] = params[:max_time]
      session[:category] = params[:category]
    else
      session[:max_time] = nil if params[:query].blank?
      session[:category] = nil if params[:query].blank?
      @max_time = session[:max_time]
      @category = session[:category]
    end

    if @query.present?
      @recipes = Recipe.search_by_name(@query)
    else
      @recipes = Recipe.all
    end

    if @max_time.present? && @max_time != "no-limit"
      @recipes = @recipes.reject { |recipe| recipe.prep_time + recipe.cook_time > @max_time.to_i }
    end

    if @category.present? && @category != 'all'
      @recipes = @recipes.select do |recipe|
        recipe.tags.any? { |tag| tag.name == @category }
      end
    end

    if user_signed_in?

      @recipes = @recipes.sort do |recipe1, recipe2|
        # # For recipes that have the same number of missing ingredients
        # # Sort them by the highest number of matching ingredients
        # if recipe1.how_many_ingredients_to_buy(current_user) == recipe2.how_many_ingredients_to_buy(current_user)
        #   recipe2.matching_ingredients(current_user).count <=> recipe1.matching_ingredients(current_user).count
        # # Otherwise, sort them by the least missing ingredients
        # else
          recipe1.how_many_ingredients_to_buy(current_user) <=> recipe2.how_many_ingredients_to_buy(current_user)
        # end
      end

      @recipes_not_ready = @recipes.select { |recipe| recipe.missing_ingredients(current_user).length.positive? }
      @recipes_ready = @recipes.select { |recipe| recipe.missing_ingredients(current_user).empty? }

      # Give all the recipes in the current user's wishlist
      @wishlist_recipes = []
      WishlistItem.where(user: current_user).each do |wishlist_item|
        @wishlist_recipes << wishlist_item.recipe
      end

      @wishlist_recipes.sort do |recipe1, recipe2|
        # # For recipes that have the same number of missing ingredients
        # # Sort them by the highest number of matching ingredients
        # if recipe1.how_many_ingredients_to_buy(@fridge_items) == recipe2.how_many_ingredients_to_buy(@fridge_items)
        #   recipe2.matching_ingredients(@fridge_items).count <=> recipe1.matching_ingredients(@fridge_items).count
        # # Otherwise, sort them by the least missing ingredients
        # else
          recipe1.how_many_ingredients_to_buy(current_user) <=> recipe2.how_many_ingredients_to_buy(current_user)
        # end
      end
    else
      @recipes_not_ready = @recipes
      @recipes_ready = []
    end
  end

  def index_owner
    @current_user = current_user
    @recipes = Recipe.where(user: current_user)
  end

  def popup
    raise
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

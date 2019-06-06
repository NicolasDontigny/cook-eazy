class FridgeItemsController < ApplicationController
  before_action :set_fridge, only: %i[index fill]
  before_action :set_fridge_item, only: %i[delete decrease increase]

  def index
    @fridge_item = FridgeItem.new
    @categories = filtered_categories
  end

  def create
    @categories = filtered_categories
    @fridge_item = FridgeItem.where(user: current_user).find_by(ingredient_id: params[:fridge_item][:ingredient_id])

    if @fridge_item
      @fridge_item.quantity += params[:fridge_item][:quantity].to_i
      render_refresh_js
    else
      @fridge_item = FridgeItem.new(params_permit)
      @fridge_item.user = current_user
      render_create_js
    end
  end

  def delete
    @fridge_item.destroy!

    respond_to do |format|
      format.html { redirect_to fridge_path }
      format.js { render 'delete_item.js.erb' }
    end
  end

  def increase
    @fridge_item.quantity += 1

    render_refresh_js
  end

  def decrease
    @fridge_item.quantity -= 1 unless @fridge_item.quantity.zero?

    render_refresh_js
  end

  def empty
    @recipe = Recipe.find(params["recipe_id"].to_i)

    cooked_recipe = CookedRecipe.new(
      recipe: @recipe,
      user: current_user
    )

    cooked_recipe.save

    @recipe_items = @recipe.recipe_items
    @recipe_items.each do |recipe_item|
      @fridge_item = FridgeItem.find_by(ingredient: recipe_item.ingredient)
      if @fridge_item && @fridge_item.quantity <= recipe_item.quantity
        @fridge_item.destroy
      elsif @fridge_item && @fridge_item.quantity > recipe_item.quantity
        @fridge_item.quantity -= recipe_item.quantity
        @fridge_item.save
      end
    end

    respond_to do |format|
      format.html { redirect_to recipes_path }
      format.js { render 'recipes/done' }
    end
  end

  private

  def params_permit
    params.require(:fridge_item).permit(:ingredient_id, :quantity)
  end

  def set_fridge_item
    @fridge_item = FridgeItem.find(params[:id])
  end

  def set_fridge
    @fridge_items = FridgeItem.where(user: current_user).order('created_at DESC')
  end

  def render_create_js
    if @fridge_item.save
      set_fridge
      @categories = filtered_categories
      respond_to do |format|
        format.html { redirect_to fridge_path_path }
        format.js
      end
    else
      set_fridge
      @categories = filtered_categories
      respond_to do |format|
        format.html { render 'index' }
        format.js
      end
    end
  end

  def render_refresh_js
    @fridge_item.save!

    respond_to do |format|
      format.html { redirect_to fridge_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def filtered_categories
    set_fridge

    sorted_fridge_items = @fridge_items.sort_by do |item|
      item.ingredient.category
    end

    filtered_categories = sorted_fridge_items.map do |item|
      item.ingredient.category
    end

    if filtered_categories.length > 1
      filtered_categories.uniq
    else
      filtered_categories
    end
  end
end

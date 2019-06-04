class GroceryItemsController < ApplicationController
  before_action :set_grocery_item, only: %i[check uncheck decrease increase destroy]

  def index
    @grocery_items = GroceryItem.where(user: current_user).order('created_at DESC')
    @categories = filtered_categories
    # @grocery_item = GroceryItem.new
  end

  def add
    @recipe = Recipe.find(params[:recipe_id])
    @missing_ingredients = @recipe.missing_ingredients(current_user)

    @missing_ingredients.each do |recipe_item|
      add_item_to_grocery_list(recipe_item)
    end

    respond_to do |format|
      format.html { redirect_to recipes_path }
      format.js { render 'add.js.erb' }
    end
  end

  def create
    @grocery_item = GroceryItem.where(user: current_user).find_by(ingredient_id: params[:grocery_item][:ingredient_id])

    if @grocery_item
      @grocery_item.quantity += params[:grocery_item][:quantity].to_i
      render_refresh_js
    else
      @grocery_item = GroceryItem.new(params_permit)
      @grocery_item.user = current_user
      render_create_js
    end
  end

  def check
    @grocery_item.checked = true

    render_refresh_js
  end

  def uncheck
    @grocery_item.checked = false

    render_refresh_js
  end

  def decrease
    @grocery_item.quantity -= 1 unless @grocery_item.quantity == 1

    render_refresh_js
  end

  def increase
    @grocery_item.quantity += 1

    render_refresh_js
  end

  def update
    @grocery_items = GroceryItem.where(checked: true)

    fill_fridge(@grocery_items)

    @grocery_items.each(&:destroy)

    render_update_js
  end

  def destroy
    @grocery_item.destroy

    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'destroy.js.erb' }
    end
  end

  private

  def params_permit
    params.require('grocery_item').permit(:ingredient_id, :quantity)
  end

  def set_grocery_item
    @grocery_item = GroceryItem.find(params[:id])
  end

  def render_create_js
    if @grocery_item.save
      @grocery_items = GroceryItem.where(user: current_user).order('created_at DESC')
      @categories = filtered_categories
      respond_to do |format|
        format.html { redirect_to grocery_items_path }
        format.js
      end
    else
      @grocery_items = GroceryItem.where(user: current_user)
      @categories = filtered_categories
      respond_to do |format|
        format.html { render 'index' }
        format.js
      end
    end
  end

  def render_refresh_js
    @grocery_item&.save

    respond_to do |format|
      format.html { redirect_to grocery_items_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def render_update_js
    respond_to do |format|
      format.html { redirect_to grocery_items_path }
      format.js { render 'update_grocery_list.js.erb' }
    end
  end

  def add_item_to_grocery_list(recipe_item)
    # Check if recipe_item is already in the Grocery List
    @grocery_item = GroceryItem.where(user: current_user).find_by(ingredient: recipe_item.ingredient)

    # If it is, update its quantity
    if @grocery_item
      @grocery_item.quantity += recipe_item.how_many_missing
    # If it's not, create a new Grocery Item with the correct quantity
    else
      quantity = recipe_item.how_many_missing
      @grocery_item = GroceryItem.new(
        quantity: quantity,
        ingredient: recipe_item.ingredient,
        user: current_user
      )
    end

    @grocery_item.save!
  end

  def filtered_categories
    @grocery_items = GroceryItem.where(user: current_user).order('created_at DESC')

    sorted_grocery_items = @grocery_items.sort_by do |item|
      item.ingredient.category
    end
    filtered_categories = sorted_grocery_items.map do |item|
      item.ingredient.category
    end
    if filtered_categories.length > 1
      filtered_categories.uniq
    else
      filtered_categories
    end
  end
end

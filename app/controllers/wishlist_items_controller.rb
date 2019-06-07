class WishlistItemsController < ApplicationController
  before_action :set_recipe, only: %i[create destroy]

  def index
    @wishlist_items = WishlistItem.where(user: current_user).order('created_at DESC')
  end

  def new

  end

  def create
    @wishlist_item = WishlistItem.new
    @wishlist_item.user = current_user

    @missing_ingredients = @recipe.missing_ingredients(current_user)

    # Only add the recipe if it is not already in the Wishlist
    @wishlist_item.recipe = @recipe unless WishlistItem.find_by(recipe: @recipe)

    if @wishlist_item.save
      respond_to do |format|
        format.html { redirect_to recipes_path }
        format.js { render 'new_wishlist_item.js.erb' }
      end
    else
      respond_to do |format|
        format.html { redirect_to recipes_path }
        format.js { render 'new_wishlist_item_exists.js.erb' }
      end
    end
  end

  def destroy
    @wishlist_item = WishlistItem.find_by(recipe: @recipe)

    @wishlist_item.destroy

    @wishlist_empty = WishlistItem.all.empty?

    respond_to do |format|
      format.html { redirect_to recipes_path }
      format.js { render 'remove_wishlist_item.js.erb' }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end

class CookingListsItemsController < ApplicationController
  def show
    @cooking_list_items = CookinglistItem.where(user: current_user)
  end

  def add
    recipe = Recipe.find(params[:id])
    cooking_list_item = CookingListItem.new
    cooking_list_item.recipe = recipe
    cooking_list_item.user = current_user
    cooking_list_item.save!
  end
end

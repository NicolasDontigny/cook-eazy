class CookingListItemsController < ApplicationController
  def index
    @cooking_list_items = CookingListItem.where(user: current_user).order('created_at DESC')
  end

  def create
    @recipe = Recipe.find(params[:id])
    @cooking_list_item = CookingListItem.new
    @cooking_list_item.recipe = @recipe
    @cooking_list_item.user = current_user
    @cooking_list_item.save!
  end
end

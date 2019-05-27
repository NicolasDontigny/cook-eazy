class GroceryListItemsController < ApplicationController
  def index
    @grocery_list_items = GroceryListItem.where(user: current_user)
  end
end

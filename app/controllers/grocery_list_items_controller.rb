class GroceryListItemsController < ApplicationController
  before_action :set_grocery_item, only: %i[check uncheck decrease increase]

  def index
    @grocery_list_items = GroceryListItem.where(user: current_user).order('created_at DESC')
    @grocery_list_item = GroceryListItem.new
  end

  def create
    @grocery_list_item = GroceryListItem.new(params_permit)
    @grocery_list_item.user = current_user
    if @grocery_list_item.save
      respond_to do |format|
        format.html { redirect_to grocery_list_path }
        format.js
      end
    else
      @grocery_list_items = GroceryListItem.where(user: current_user)
      @grocery_list_item = GroceryListItem.new
      respond_to do |format|
        format.html { render 'index' }
        format.js
      end
    end
  end

  def check
    @grocery_item.checked = true
    @grocery_item.save!

    respond_to do |format|
      format.html { redirect_to grocery_list_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def uncheck
    @grocery_item.checked = false
    @grocery_item.save

    respond_to do |format|
      format.html { redirect_to grocery_list_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def decrease
    @grocery_item.quantity -= 1
    @grocery_item.save

    respond_to do |format|
      format.html { redirect_to grocery_list_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def increase
    @grocery_item.quantity += 1
    @grocery_item.save

    respond_to do |format|
      format.html { redirect_to grocery_list_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def update
    @grocery_list_items = GroceryListItem.where(checked: true)
  end

  private

  def params_permit
    params.require('grocery_list_item').permit(:ingredient_id, :quantity)
  end

  def set_grocery_item
    @grocery_item = GroceryListItem.find(params[:id])
  end
end

class GroceryItemsController < ApplicationController
  before_action :set_grocery_item, only: %i[check uncheck decrease increase]

  def index
    @grocery_items = GroceryItem.where(user: current_user).order('created_at DESC')
    # @grocery_item = GroceryItem.new
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
      respond_to do |format|
        format.html { redirect_to grocery_items_path }
        format.js
      end
    else
      @grocery_items = GroceryItem.where(user: current_user)
      # @grocery_item = GroceryItem.new
      respond_to do |format|
        format.html { render 'index' }
        format.js { render 'create.js.erb' }
      end
    end
  end

  def render_refresh_js
    @grocery_item.save

    respond_to do |format|
      format.html { redirect_to grocery_items_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end
end

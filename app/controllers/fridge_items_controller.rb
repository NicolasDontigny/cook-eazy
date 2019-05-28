class FridgeItemsController < ApplicationController
  before_action :set_fridge_item, only: %i[delete decrease increase]

  def index
    @fridge_items = FridgeItem.where(user: current_user).order('created_at DESC')
    @fridge_item = FridgeItem.new
  end

  def create
    @fridge_item = FridgeItem.new(params_permit)
    @fridge_item.user = current_user

    if @fridge_item.save
      redirect_to fridge_path
    else
      render 'fridge_items/index'
    end
  end

  def delete
    @fridge_item.destroy!
  end

  def increase
    @fridge_item.quantity += 1
    @fridge_item.save

    if @fridge_item.save
      redirect_to fridge_path
    else
      render 'fridge_items/index'
    end
  end

  def decrease
    @fridge_item.quantity -= 1
    @fridge_item.save

    if @fridge_item.save
      redirect_to fridge_path
    else
      render 'fridge_items/index'
    end
  end

  def fill
    @grocery_list_items.each do |ingredient|
      @fridge_item = FridgeItem.where(ingredient: ingredient)
      @fridge_item.user = current_user
      @fridge_item.save
    end
  end

  def empty
    @recipe_ingredients.each do |ingredient|
      @fridge_item = FridgeItem.where(ingredient: ingredient)
      @fridge_item.destroy!
    end
  end

  private

  def params_permit
    params.require(:fridge_item).permit(:ingredient_id, :quantity)
  end

  def set_fridge_item
    @fridge_item = FridgeItem.find(params[:id])
  end
end

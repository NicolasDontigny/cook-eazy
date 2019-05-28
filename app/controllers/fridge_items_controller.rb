class FridgeItemsController < ApplicationController
  before_action :set_fridge, only: %i[index create fill]
  before_action :set_fridge_item, only: %i[delete decrease increase]

  def index
    @fridge_item = FridgeItem.new
  end

  def create
    @fridge_item = FridgeItem.new(params_permit)

    @fridge_item.user = current_user

    if @fridge_item.save
      respond_to do |format|
        format.html { redirect_to fridge_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js
      end
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
    @fridge_item.save!

    respond_to do |format|
      format.html { redirect_to fridge_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def decrease
    @fridge_item.quantity -= 1
    @fridge_item.save!

    respond_to do |format|
      format.html { redirect_to fridge_path }
      format.js { render 'refresh_item.js.erb' }
    end
  end

  def fill
    @grocery_list_items.each do |ingredient|
      @fridge_items.each do |item|
        if item.ingredient == ingredient
          item.ingredient.quantity += ingredient.quantity
          item.save!
        else
          @fridge_item = FridgeItem.new(ingredient)
          @fridge_item.user = current_user
          @fridge_item.save!
        end
      end
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

  def set_fridge
    @fridge_items = FridgeItem.where(user: current_user).order('created_at DESC')
  end
end

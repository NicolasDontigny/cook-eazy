class FridgeItemsController < ApplicationController
  def index
    @fridge_items = FridgeItem.where(user: current_user)
  end

  def create
    ingredient = Ingredient.find(params[:id])
    fridge_item = FridgeItem.new
    fridge_item.ingredient = ingredient
    fridge_item.user = current_user
    fridge_item.save!
  end

  def delete
    fridge_item = FridgeItem.find(params[:id])
    fridge_item.destroy!
  end

  def increase
    fridge_item = FridgeItem.find(params[:id])
    fridge_item.quantity += 1
    fridge_item.save!
  end

  def decrease
    fridge_item = FridgeItem.find(params[:id])
    fridge_item.quantity -= 1
    fridge_item.save!
  end

  def fill
    @grocery_list_items.each do |ingredient|
      fridge_item = FridgeItem.new
      fridge_item.ingredient = ingredient
      fridge_item.user = current_user
      fridge_item.save!
    end
  end

  def empty
    @recipe_ingredients.each do |ingredient|
      fridge_item = FridgeItem.where(ingredient: ingredient)
      fridge_item.destroy!
    end
  end
end

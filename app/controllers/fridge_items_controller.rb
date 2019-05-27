class FridgeItemsController < ApplicationController
  def show
    @fridge_items = FridgeItem.where(user: current_user)
  end

  def add

  end

  def delete

  end

  def increase

  end

  def decrease

  end

  def fill

  end

  def empty

  end
end

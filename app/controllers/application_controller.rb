class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def fill_fridge(grocery_items)
    grocery_items.each do |grocery_item|
      fridge_item = FridgeItem.find_by(ingredient_id: grocery_item.ingredient.id)

      if fridge_item
        fridge_item.quantity += grocery_item.quantity
      else
        fridge_item = FridgeItem.new(
          ingredient: grocery_item.ingredient,
          quantity: grocery_item.quantity,
          user: current_user
        )
      end
      fridge_item.save!
    end
  end
end

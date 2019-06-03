class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_fridge_items, only: %i[missing_ingredients insufficient_ingredients matching_ingredients how_many_ingredients_to_buy]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar) }
  end

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

  def empty_fridge(ingredients)
    ingredients.each do |ingredient|
      fridge_item = FridgeItem.find_by(ingredient_id: ingredient.id)

      next unless fridge_item

      if fridge_item.quantity <= ingredient.quantity
        fridge_item.destroy
      else
        fridge_item.quantity -= ingredient.quantity
      end
      fridge_item.save!
    end
  end
end

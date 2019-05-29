class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

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
end

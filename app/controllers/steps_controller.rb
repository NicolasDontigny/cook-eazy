class StepsController < ApplicationController
  before_action :set_recipe, only: %i[index]

  def index
    @steps = @recipe.steps
    @fridge_items = FridgeItem.where(user: current_user)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end

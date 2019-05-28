class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @recipes = Recipe.all
  end

  def steps
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end

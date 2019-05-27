class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
  end

  def steps
  end

  def show
  end
end

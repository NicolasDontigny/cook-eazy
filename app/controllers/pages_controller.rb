class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
    @no_navbar = true
    if user_signed_in?
      redirect_to(recipes_path)
    end
  end

  def test
    @recipe = Recipe.second
  end
end

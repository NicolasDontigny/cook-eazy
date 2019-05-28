class ReviewsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new(params_permit)
    @review.recipe = @recipe
    @review.user = current_user
    @review.date = Date.today

    if @review.save
      @recipe.update_ratings!
      respond_to do |format|
        format.html { redirect_to recipe_path(@recipe.id) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'recipes/show' }
        format.js
      end
    end
  end

  private

  def params_permit
    params.require(:review).permit(:content, :rating)
  end
end

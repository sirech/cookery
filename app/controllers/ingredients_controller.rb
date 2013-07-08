class IngredientsController < ApplicationController

  include JsonResponse

  def index
    @ingredients = Ingredient.order('name').all
    respond_to do |format|
      format.json { render json: @ingredients }
    end
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    create_as_json @ingredient
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end

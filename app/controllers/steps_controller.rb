class StepsController < ApplicationController

  include JsonResponse

  def create
    @step = Step.new(step_params)
    add_ingredients
    create_as_json @step
  end

  private

  def step_params
    params.require(:step).permit(:name, :duration, :notes)
  end

  def add_ingredients
    if params[:step][:ingredients] && params[:step][:ingredients] != '[]'
      ingredients = Ingredient.where(name: params[:step][:ingredients].split(','))
      @step.ingredients = ingredients if ingredients.any?
    end
  end
end

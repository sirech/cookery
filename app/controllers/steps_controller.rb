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
    if params[:step][:quantities]
      @step.quantities = params[:step][:quantities].map do |quantity|
        ingredient = Ingredient.where(name: quantity[:ingredient]).first
        return nil unless ingredient

        Quantity.create(step: @step, ingredient: ingredient, unit: quantity[:unit], amount: quantity[:amount])
      end.compact
    end
  end
end

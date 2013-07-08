class StepsController < ApplicationController

  include JsonResponse

  def create
    @step = Step.new(step_params)
    create_as_json @step
  end

  private

  def step_params
    params.require(:step).permit(:name, :duration)
  end
end

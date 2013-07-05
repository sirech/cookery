class CategoriesController < ApplicationController

  include JsonResponse

  def create
    @category = Category.new(category_params)
    respond_as_json @category
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end

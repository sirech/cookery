class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe.order(sort_parameters).page(params[:page])
  end

  # GET /recipes/1
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    add_category params[:category]

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /recipes/1
  def update
    add_category params[:category]

    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :difficulty, :picture, :first_step)
  end

  def add_category(category)
    if category.present?
      tag = Category.find_by_name(category) || Category.create(name: category)
      @recipe.categories << tag
    end
  end

  def sort_parameters
    direction = params[:direction] == 'desc' ? 'desc' : 'asc'
    "lower(name) #{direction}"
  end
end

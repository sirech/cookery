class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_example_step, except: [:index, :destroy]

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
    add_steps

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

  def set_example_step
    @example_step = Step.new
  end

  def recipe_params
    add_extra_categories
    params.require(:recipe).permit(:name, :difficulty, :picture, :category_ids => [])
  end

  def add_extra_categories
    if params[:'extra-category']
      categories = params[:'extra-category'].split(/[ ,]/).map(&:strip).delete_if(&:blank?)
      categories = categories.map { |c| Category.where(name: c).first_or_create.id }
      params[:recipe][:category_ids] += categories
    end
  end

  def add_steps
    if params[:recipe][:steps] && params[:recipe][:steps] != '[]'
      steps = Step.find(params[:recipe][:steps].split(','))

      if steps.any?
        @recipe.first_step = steps.first
        steps.each_cons(2) do |parent,child|
          parent.children << child
        end

        steps.map do |step|
          step.recipe = @recipe
          step.save
        end
      end
    end
  end

  def sort_parameters
    direction = params[:direction] == 'desc' ? 'desc' : 'asc'
    "lower(name) #{direction}"
  end
end

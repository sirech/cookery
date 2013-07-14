class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_example_step, except: [:index, :destroy]
  before_action :convert_duration, only: [:create, :update]

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
    params.require(:recipe).permit(:name, :difficulty, :pictures,
      :category_ids => [],
      :steps_attributes => [:_destroy, :name, :duration, :notes])
  end

  def add_extra_categories
    if params[:'extra-category']
      categories = params[:'extra-category'].split(/[ ,]/).map(&:strip).delete_if(&:blank?)
      categories = categories.map { |c| Category.where(name: c).first_or_create.id }
      params[:recipe][:category_ids] += categories
    end
  end

  def convert_duration
    if params[:recipe] && params[:recipe][:steps_attributes]
      params[:recipe][:steps_attributes].each_value do |s|
        s[:duration] = "#{s[:duration].to_i.minutes}" unless s[:duration].blank?
      end
    end
  end

  def sort_parameters
    direction = params[:direction] == 'desc' ? 'desc' : 'asc'
    "lower(name) #{direction}"
  end
end

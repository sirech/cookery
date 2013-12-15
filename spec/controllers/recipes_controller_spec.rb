require 'spec_helper'

describe RecipesController do
  include AttributesHelper
  include CreateHelper
  include Devise::TestHelpers

  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in user

    [
      ['paella', 'medium'],
      ['Lentejas', 'easy'],
      ['huevo frito', 'difficult']
    ].each do |name, difficulty|
      FactoryGirl.create(:recipe, name: name, difficulty: difficulty, author: user)
    end
  end

  describe 'index' do

    it 'returns the recipes sorted by name (case insensitive)' do
      get :index
      expect(assigns(:recipes).map(&:name)).to eq(['huevo frito', 'Lentejas', 'paella'])
    end

    it 'can be sorted inversely with the direction parameter' do
      get :index, direction: 'desc'
      expect(assigns(:recipes).map(&:name)).to eq(['paella', 'Lentejas', 'huevo frito'])
    end

  end

  describe 'create' do

    let(:attributes) { recipe_as_request(:recipe_multi_step) }

    def without(*attrs)
      attributes.tap { |r| attrs.each { |a| r.delete(a) } }
    end

    it 'generates a valid recipe' do
      post :create, recipe: attributes
      expect(assigns(:recipe).valid?).to be_true
    end

    it 'creates a new recipe in the db' do
      expect { post :create, recipe: attributes }.to change { Recipe.count }.by(1)
    end

    %w(name difficulty).each do |required|
      it 'rejects a recipe without a #{required}' do
        post :create, recipe: without(required.to_sym)
        expect(assigns(:recipe).valid?).to be_false
      end
    end

    [
      'tag1, tag2, tag3',
      'tag1 tag2 tag3',
      'tag1,tag2 tag3',
      ' tag1  tag2 tag3',
      'tag1, tag2, tag1, tag3'
    ].each do |extra_tags|
      it "adds extra categories in the form \"#{extra_tags}\"" do
        post :create, recipe: attributes, 'extra-category' => extra_tags
        expect(assigns(:recipe).categories.map(&:name)).to include(*%w(tag1 tag2 tag3))
      end
    end

    it 'creates the steps' do
      post :create, recipe: attributes
      expect(assigns(:recipe).steps.map(&:name)).to eq(%w(prepare cook rest))
    end

    it 'sets the recipe for every step' do
      post :create, recipe: attributes
      assigns(:recipe).steps.each do |step|
        expect(step).not_to be_nil
      end
    end

    it 'does not create any step if there are no steps in the request' do
      attributes.delete :steps_attributes
      post :create, recipe: attributes
      expect(assigns(:recipe).steps).to be_empty
    end

    it 'automatically converts duration to minutes' do
      post :create, recipe: attributes
      expect(assigns(:recipe).duration).to eq(30.minutes)
    end

    it 'creates a new ingredient if the id is not there' do
      attributes[:steps_attributes]['0']['quantities_attributes']['0'].tap do |h|
        h.delete 'ingredient_id'
        h['ingredient'] = 'unknown'
      end

      post :create, recipe: attributes
      expect(Ingredient.find_by_name('unknown')).not_to be_nil
    end

    it_behaves_like 'create relations', Recipe, :categories
    it_behaves_like 'create relations', Recipe, :videos
    it_behaves_like 'create relations', Recipe, :quantities, :steps, :first
    it_behaves_like 'create relations', Recipe, :ingredients, :steps, :first
  end

  describe 'update' do

    let(:attributes) { recipe_as_request(:recipe_multi_step) }

    before(:each) do
      post :create, recipe: attributes
      @existing = assigns(:recipe)

      @existing.steps.each_with_index do |step, i|
        attributes[:steps_attributes]["#{i}"]['id'] = step.id

        step.quantities.each_with_index do |quantity, j|
          attributes[:steps_attributes]["#{i}"]['quantities_attributes']["#{j}"]['id'] = quantity.id
        end
      end
    end

    it 'removes categories' do
      expect(@existing.categories).not_to be_empty
      put :update, id: @existing.id, recipe: attributes.tap { |attr| attr[:category_ids] = [] }
      expect(assigns(:recipe).categories).to be_empty
    end

    it 'removes steps if they are marked' do
      step_name = attributes[:steps_attributes]['0']['name']
      attributes[:steps_attributes]['0']['_destroy'] = '1'

      put :update, id: @existing.id, recipe: attributes

      expect(assigns(:recipe).steps.map(&:name)).to eq(@existing.steps.map(&:name) - [step_name])
    end
  end

  describe 'search' do
    it 'returns only the recipes that match the search query' do
      get :search, search: 'huevo'
      expect(assigns(:recipes).map(&:name)).to eq(['huevo frito'])
    end
  end
end

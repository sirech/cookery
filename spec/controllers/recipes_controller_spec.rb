require 'spec_helper'

describe RecipesController do

  before(:each) do
    [
      ['paella', 'medium'],
      ['Lentejas', 'easy'],
      ['huevo frito', 'difficult']
    ].each do |name, difficulty|
      FactoryGirl.create(:recipe, name: name, difficulty: difficulty)
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

    it 'generates a valid recipe' do
      post :create, recipe: FactoryGirl.attributes_for(:recipe).tap { |r| r.delete(:first_step) }
      expect(assigns(:recipe).valid?).to be_true
    end

    it 'rejects a recipe without a name' do
      post :create, recipe: FactoryGirl.attributes_for(:recipe).tap { |r| [:name, :first_step].each { |a| r.delete(a) } }
      expect(assigns(:recipe).valid?).to be_false
    end
  end
end

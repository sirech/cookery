require 'spec_helper'

describe RecipesController do

  before(:each) do
    FactoryGirl.create(:recipe, name: 'paella', difficulty: 'medium')
    FactoryGirl.create(:recipe, name: 'Lentejas', difficulty: 'easy')
    FactoryGirl.create(:recipe, name: 'huevo frito', difficulty: 'difficult')
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
end

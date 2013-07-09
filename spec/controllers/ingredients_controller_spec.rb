require 'spec_helper'

describe IngredientsController do

  let(:attributes) { FactoryGirl.attributes_for(:ingredient) }

  before(:each) do
    FactoryGirl.create(:ingredient)
  end

  describe 'index' do
    it 'returns the list of ingredients' do
      get :index, format: :json
      expect(assigns(:ingredients)).not_to be_empty
    end
  end

  describe 'create' do

    it 'generates a valid ingredient' do
      post :create, ingredient: attributes, format: :json
        expect(assigns(:ingredient).valid?).to be_true
    end

    it 'creates a new ingredient in the db' do
      expect { post :create, ingredient: attributes, format: :json }.to change { Ingredient.count }.by(1)
    end

    it 'returns a created response code' do
      post :create, ingredient: attributes, format: :json
      expect(response.status).to eq(201)
    end
  end
end

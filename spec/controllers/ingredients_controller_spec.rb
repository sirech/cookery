require 'spec_helper'
require 'support/create_helper'

describe IngredientsController do
  include CreateHelper

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
    it_behaves_like 'create a new record', Ingredient
  end
end

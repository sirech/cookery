require 'spec_helper'
require 'support/create_helper'

describe StepsController do
  include CreateHelper

  let(:ingredients) { FactoryGirl.create_list(:ingredient, 3) }

  let(:attributes) do
    FactoryGirl.attributes_for(:step_last).tap do |s|
      s[:quantities] = ingredients.map do |ingredient|
        {
          ingredient: ingredient.name,
          unit: 'pinch',
          amount: 1
        }
      end
    end
  end

  describe 'create' do
    it_behaves_like 'create a new record', Step

    it 'adds new ingredients' do
      post :create, step: attributes, format: :json

      expect(assigns(:step).valid?).to be_true
      expect(assigns(:step).ingredients).not_to be_empty
    end
  end
end

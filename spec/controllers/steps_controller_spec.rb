require 'spec_helper'
require 'support/create_helper'

describe StepsController do
  include CreateHelper

  let(:attributes) {
    FactoryGirl.attributes_for(:step_cook).tap do |s|
      s[:ingredients] = s[:ingredients].map(&:name).join ','
    end
  }

  describe 'create' do
    it_behaves_like 'create a new record', Step

    it 'adds new ingredients' do
      post :create, step: attributes, format: :json

      expect(assigns(:step).valid?).to be_true
      expect(assigns(:step).ingredients).not_to be_empty
    end
  end
end

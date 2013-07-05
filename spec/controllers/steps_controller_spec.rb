require 'spec_helper'

describe StepsController do

  let(:attributes) { FactoryGirl.attributes_for(:step_last) }

  describe 'create' do

    it 'generates a valid step' do
      post :create, step: attributes, format: :json
        expect(assigns(:step).valid?).to be_true
    end

    it 'creates a new step in the db' do
        expect { post :create, step: attributes, format: :json }.to change { Step.count }.by(1)
    end

  end
end

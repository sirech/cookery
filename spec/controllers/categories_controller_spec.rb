require 'spec_helper'

describe CategoriesController do

  let(:attributes) { FactoryGirl.attributes_for(:category) }

  describe 'create' do

    it 'generates a valid category' do
      post :create, category: attributes, format: :json
        expect(assigns(:category).valid?).to be_true
    end

    it 'creates a new category in the db' do
        expect { post :create, category: attributes, format: :json }.to change { Category.count }.by(1)
    end

  end
end

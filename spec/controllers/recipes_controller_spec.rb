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

  context '<input>' do

    let(:attributes) {
      FactoryGirl.attributes_for(:recipe).tap do |r|
        r.delete(:first_step)
        r[:category_ids] = r[:categories].map(&:id)
      end
    }

    def without *attrs
      attributes.tap { |r| attrs.each { |a| r.delete(a) } }
    end

    describe 'create' do

      it 'generates a valid recipe' do
        post :create, recipe: attributes
        expect(assigns(:recipe).valid?).to be_true
      end

      %w(name difficulty).each do |required|
        it 'rejects a recipe without a #{required}' do
          post :create, recipe: without(required.to_sym)
          expect(assigns(:recipe).valid?).to be_false
        end
      end

      it 'adds new categories' do
        post :create, recipe: attributes

        expect(assigns(:recipe).valid?).to be_true
        expect(assigns(:recipe).categories).not_to be_empty
      end

    end

    describe 'update' do

      before(:each) do
        post :create, recipe: attributes
        @existing = assigns(:recipe)
      end

      it 'removes categories' do
        expect(@existing.categories).not_to be_empty
        put :update, id: @existing.id, recipe: attributes.tap { |attr| attr[:category_ids] = [] }
        expect(assigns(:recipe).categories).to be_empty
      end
    end
  end
end

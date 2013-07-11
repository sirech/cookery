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
      FactoryGirl.attributes_for(:recipe_multi_step).tap do |r|
        r[:steps] = r[:steps].map(&:id).join ','
        r[:category_ids] = r[:categories].map(&:id)
      end
    }

    def without(*attrs)
      attributes.tap { |r| attrs.each { |a| r.delete(a) } }
    end

    describe 'create' do

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

      it 'adds new categories' do
        post :create, recipe: attributes

        expect(assigns(:recipe).valid?).to be_true
        expect(assigns(:recipe).categories).not_to be_empty
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

      it 'creates the step hierarchy' do
        post :create, recipe: attributes
        expect(assigns(:recipe).steps.map(&:name)).to eq(%w(prepare cook rest))
      end

      it 'sets the recipe for every step' do
        post :create, recipe: attributes
        assigns(:recipe).steps.each do |step|
          expect(step).not_to be_nil
        end
      end

      it 'does not create any step if the steps parameter is empty' do
        attributes[:steps] = '[]'
        post :create, recipe: attributes
        expect(assigns(:recipe).steps).to be_empty
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

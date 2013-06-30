require 'spec_helper'

describe Recipe do

  let(:recipe) do
    Recipe.create name: 'Lasagna',
                  difficulty: 'medium',
                  categories: [FactoryGirl.build(:category)],
                  first_step: FactoryGirl.build(:step_first)
  end

  describe '#difficulty' do
    it 'should only accept valid difficulty levels' do
      recipe.difficulty = 'insane'
      expect(recipe.valid?).to be_false
    end
  end

  describe '#steps' do
    it 'should return the steps in the recipe taking into account their hierarchy' do
      expect(recipe.steps.map(&:name)).to eq(%w(prepare cook rest))
    end
  end

  describe '#duration' do
    it 'should compute the total duration based on the duration of each step' do
      expect(recipe.duration).to eq(30.minutes)
    end
  end

  describe '#ingredients' do
    it 'should contain the ingredients of all the steps in the recipe' do
      expect(recipe.ingredients.length).to eq(6)
    end
  end
end

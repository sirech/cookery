require 'spec_helper'

describe Recipe do

  let(:recipe) do
    Recipe.create name: 'Lasagna',
                  difficulty: 'medium',
                  categories: [FactoryGirl.build(:category)],
                  steps: [:step_first, :step_cook, :step_last].map { |s| FactoryGirl.create(s) },
                  author: FactoryGirl.create(:user)
  end

  describe '#picture' do

    it 'should return the first picture of the list' do
      r = FactoryGirl.create(:recipe_with_pictures)
      expect(r.picture.photo.url).not_to be_nil
    end

    it 'should return a default if there are no pictures' do
      expect(recipe.picture.photo.url).to match(/pan/)
    end

  end

  describe '#difficulty' do
    it 'should only accept valid difficulty levels' do
      recipe.difficulty = 'insane'
      expect(recipe.valid?).to be_false
    end
  end

  describe '#steps' do
    it 'should return the steps in the recipe taking into account their order' do
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
      expect(recipe.ingredients).to have(6).items
    end
  end

  describe '#videos' do
    it 'should be able to store urls' do
      recipe.videos << Video.new(url: 'http://youtube.com')
      recipe.videos << Video.new(url: 'https://youtube.com')

      recipe.save
      recipe.reload

      expect(recipe.videos).to have(2).items
    end
  end

  describe '#servings' do
    it 'should only accept positive numbers' do
      recipe.servings = 0
      expect(recipe.valid?).to be_false
    end
  end
end

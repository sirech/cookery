require 'spec_helper'

describe Recipe do

  let(:recipe) do
    Recipe.create name: 'Lasagna',
                  difficulty: 'medium',
                  categories: [FactoryGirl.build(:category)],
                  steps: [:step_first, :step_cook, :step_last].map { |s| FactoryGirl.create(s) }
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

    it 'should be possible to change the order' do
      recipe.steps.first.move_to_bottom
      recipe.reload
      expect(recipe.steps.map(&:name)).to eq(%w(cook rest prepare))
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
    it 'should reject things that are not urls' do
      recipe.videos << 'test'
      expect(recipe.valid?).to be_false
    end

    it 'should reject non-youtube urls' do
      recipe.videos << 'http://vimeo.com'
      expect(recipe.valid?).to be_false
    end

    it 'should rewrite videos that can not be embedded' do
      recipe.videos << 'https://youtube.com/watch?v=T-eDbjeTA'

      recipe.save
      recipe.reload

      expect(recipe.videos.first).to_not match(/watch/)
    end

    it 'should be able to store urls' do
      recipe.videos << 'http://youtube.com'
      recipe.videos << 'https://youtube.com'

      recipe.save
      recipe.reload

      expect(recipe.videos).to have(2).items
    end
  end
end

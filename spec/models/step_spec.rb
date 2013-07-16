require 'spec_helper'
require 'support/numeric_helper'

describe Step do
  include NumericHelper

  describe '#duration' do
    it_behaves_like 'test numeric property', Step, :duration
  end

  describe '#ingredients' do

    let(:step) { Step.create name: 'step', duration: 0, quantities: FactoryGirl.create_list(:quantity, 3)}

    it 'can access the ingredients through the quantities' do
      expect(step.ingredients.map(&:name)).not_to be_empty
    end
  end
end

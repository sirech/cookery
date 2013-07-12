require 'spec_helper'

describe Step do

  describe '#duration' do
    it 'should not accept negative numbers' do
      expect { Step.create! name: 'Invalid', duration: -100 }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should accept zero' do
      expect { Step.create! name: 'Valid', duration: 0 }.not_to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#ingredients' do

    let(:step) { Step.create name: 'step', duration: 0, quantities: FactoryGirl.create_list(:quantity, 3)}

    it 'can access the ingredients through the quantities' do
      expect(step.ingredients.map(&:name)).not_to be_empty
    end
  end
end

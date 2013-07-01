require 'spec_helper'

describe Step do

  describe '#duration' do
    it 'should not accept negative durations' do
      expect { Step.create! name: 'Invalid', duration: -100 }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end

require 'spec_helper'
require 'support/numeric_helper'

describe Quantity do
  include NumericHelper

  describe '#amount' do
    it_behaves_like 'test numeric property', Quantity, :amount
  end
end

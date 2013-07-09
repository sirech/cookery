require 'spec_helper'
require 'support/create_helper'

describe StepsController do
  include CreateHelper

  let(:attributes) { FactoryGirl.attributes_for(:step_last) }

  describe 'create' do
    it_behaves_like 'create a new record', Step
  end
end

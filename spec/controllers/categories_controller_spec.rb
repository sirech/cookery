require 'spec_helper'
require 'support/create_helper'

describe CategoriesController do
  include CreateHelper

  let(:attributes) { FactoryGirl.attributes_for(:category) }

  describe 'create' do
    it_behaves_like 'create a new record', Category
  end
end

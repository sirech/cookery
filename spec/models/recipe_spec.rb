require 'spec_helper'

describe Recipe do

  it 'should only accept valid difficulty levels' do
    r = Recipe.new name: 'Lasagna', difficulty: 'insane'
    r.valid?.should be_false
  end
end

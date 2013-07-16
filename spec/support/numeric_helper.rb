module NumericHelper
  shared_examples_for 'test numeric property' do |klass, attribute|
    it 'should not accept negative numbers' do
      instance = klass.new attribute => -100
      expect(instance.valid?).to be_false
      expect(instance.errors.messages).to include(attribute => ["must be greater than or equal to 0"])
    end

    it 'should accept zero' do
      instance = klass.new attribute => 0
      instance.valid?
      expect(instance.errors.messages).not_to include(attribute)
    end
  end
end

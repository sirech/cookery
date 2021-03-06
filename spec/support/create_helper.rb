module CreateHelper
  shared_examples_for 'create a new record' do |klass|

    def class_as_sym(klass)
      klass.name.downcase.to_sym
    end

    it "generates a valid #{klass}" do
      sym = class_as_sym klass
      post :create,  sym => attributes, format: :json
        expect(assigns(sym).valid?).to be_true
    end

    it "creates a new #{klass} in the db" do
      sym = class_as_sym klass
      expect { post :create, sym => attributes, format: :json }.to change { klass.count }.by(1)
    end

    it 'returns a created response code' do
      sym = class_as_sym klass
      post :create, sym => attributes, format: :json
      expect(response.status).to eq(201)
    end

  end

  shared_examples_for 'create relations' do |klass, relation, *subrelations|

    def class_as_sym(klass)
      klass.name.downcase.to_sym
    end

    it "adds new #{relation}" do
      sym = class_as_sym klass
      post :create,  sym => attributes

      expect(assigns(sym).valid?).to be_true

      instance = assigns(sym)
      subrelations.each do |subrelation|
        instance = instance.send(subrelation)
      end
      expect(instance.send(relation)).not_to be_empty
    end
  end

end

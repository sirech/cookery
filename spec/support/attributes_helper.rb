module AttributesHelper

  def recipe_as_request(factory)
    raise ArgumentError.new "Invalid argument #{factory}" unless factory.is_a? Symbol

    FactoryGirl.attributes_for(factory).tap do |r|
      r[:steps_attributes] = steps_as_request(r[:steps])
      r[:category_ids] = r[:categories].map(&:id)

      [:categories, :steps].each { |key| r.delete key }
    end
  end

  def steps_as_request(steps)
    Hash[steps.map do |step|
        ["#{step.position-1}", step_as_request(step)]
      end]
  end

  def step_as_request(step)
    raise ArgumentError.new "Invalid argument #{step}" unless step.is_a? Step
    {
      '_destroy' => '',
      'name' => step.name,
      'duration' => "#{step.duration / 60}",
      'quantities_attributes' => quantities_as_request(step.quantities),
      'notes' => step.notes
    }
  end

  def quantities_as_request(quantities)
    Hash[quantities.each_with_index.map do |quantity,i|
        ["#{i}", quantity_as_request(quantity)]
      end]
  end

  def quantity_as_request(quantity)
    raise ArgumentError.new "Invalid argument #{quantity}" unless quantity.is_a? Quantity
    {
      '_destroy' => '',
      'ingredient' => quantity.ingredient.name,
      'ingredient_id' => "#{quantity.ingredient.id}",
      'amount' => "#{quantity.amount}",
      'unit' => quantity.unit
    }
  end
end

module AttributesHelper

  def recipe_as_request(factory)
    raise ArgumentError.new "Invalid argument #{factory}" unless factory.is_a? Symbol

    FactoryGirl.attributes_for(factory).tap do |r|
      r[:steps_attributes] = steps_as_request(r[:steps])
      r[:category_ids] = r[:categories].map(&:id)
      r[:videos_attributes] = videos_as_request(r[:videos])

      [:author, :categories, :steps, :videos].each { |key| r.delete key }
    end
  end

  def generate_hash_list(l, &blk)
    Hash[l.each_with_index.map do |element, i|
        ["#{i}", yield(element)]
      end]
  end

  def steps_as_request(steps)
    generate_hash_list(steps) do |step|
      raise ArgumentError.new "Invalid argument #{step}" unless step.is_a? Step
      {
        '_destroy' => '',
        'name' => step.name,
        'duration' => "#{step.duration / 60}",
        'quantities_attributes' => quantities_as_request(step.quantities),
        'notes' => step.notes
      }
    end
  end

  def quantities_as_request(quantities)
    generate_hash_list(quantities) do |quantity|
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

  def videos_as_request(videos)
    generate_hash_list(videos) do |video|
      raise ArgumentError.new "Invalid argument #{video}" unless video.is_a? Video
      {
        '_destroy' => '',
        'url' => video.url
      }
    end
  end
end

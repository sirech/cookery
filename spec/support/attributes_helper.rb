module AttributesHelper

  def recipe_as_request(factory)
    FactoryGirl.attributes_for(factory).tap do |r|
      r[:steps_attributes] = steps_as_request(r[:steps])
      r[:category_ids] = r[:categories].map(&:id)

      [:categories, :steps].each { |key| r.delete key }
    end
  end

  def steps_as_request(steps)
    Hash[steps.map { |step| ["#{step.position-1}", { '_destroy' => '', 'name' => step.name, 'duration' => "#{step.duration / 60}"}] }]
  end
end

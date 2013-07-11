class Quantity < ActiveRecord::Base
  belongs_to :step
  belongs_to :ingredient

  UNITS = %w(pinch cup teaspoon tablespoon).freeze
  validates_inclusion_of :unit, in: UNITS, allow_blank: true

end

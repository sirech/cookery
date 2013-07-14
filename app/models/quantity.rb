class Quantity < ActiveRecord::Base
  belongs_to :step
  belongs_to :ingredient

  UNITS = %w(pinch cup teaspoon tablespoon ml piece).sort.freeze
  validates_inclusion_of :unit, in: UNITS, allow_blank: true

  def self.units
    UNITS
  end
end

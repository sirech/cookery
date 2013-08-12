class Quantity < ActiveRecord::Base
  belongs_to :step
  belongs_to :ingredient

  validates_numericality_of :amount, greater_than_or_equal_to: 0

  UNITS = %w(pinch cup teaspoon tablespoon ml gr piece).sort.freeze
  validates_inclusion_of :unit, in: UNITS, allow_blank: true

  def self.units
    UNITS
  end
end

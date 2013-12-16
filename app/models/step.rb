class Step < ActiveRecord::Base
  belongs_to :recipe

  has_many :quantities
  accepts_nested_attributes_for :quantities, reject_if: :all_blank, allow_destroy: true

  has_many :ingredients, through: :quantities
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  include IsNamed
  validates_numericality_of :duration, greater_than_or_equal_to: 0
end

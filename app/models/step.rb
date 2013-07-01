class Step < ActiveRecord::Base
  belongs_to :recipe
  has_and_belongs_to_many :ingredients

  include Named
  validates_numericality_of :duration, greater_than_or_equal_to: 0

  acts_as_tree
end

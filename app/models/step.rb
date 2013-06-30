class Step < ActiveRecord::Base
  belongs_to :recipe
  has_and_belongs_to_many :ingredients

  include Named

  acts_as_tree
end

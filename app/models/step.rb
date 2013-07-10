class Step < ActiveRecord::Base
  belongs_to :recipe
  has_and_belongs_to_many :ingredients

  include Named
  validates_numericality_of :duration, greater_than_or_equal_to: 0

  acts_as_tree

  def to_json(options = {})
    Jbuilder.encode do |json|
      json.(self, :id, :name, :duration, :notes)
      json.ingredients self.ingredients do |ingredient|
        json.name ingredient.name
        json.found_at ingredient.found_at if ingredient.found_at
        json.notes ingredient.notes if ingredient.notes
      end
    end
  end
end

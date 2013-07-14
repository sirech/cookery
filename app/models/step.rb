class Step < ActiveRecord::Base
  belongs_to :recipe
  acts_as_list scope: :recipe

  has_many :quantities
  accepts_nested_attributes_for :quantities, reject_if: :all_blank, allow_destroy: true

  has_many :ingredients, through: :quantities
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  include Named
  validates_numericality_of :duration, greater_than_or_equal_to: 0

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

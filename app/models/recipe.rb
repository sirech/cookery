class Recipe < ActiveRecord::Base

  include Named

  has_and_belongs_to_many :categories
  has_one :first_step, class_name: 'Step'

  # Difficulty
  DIFFICULTY_LEVELS = %w(easy medium difficult).freeze
  validates_inclusion_of :difficulty, in: DIFFICULTY_LEVELS

  def self.difficulty_levels
    DIFFICULTY_LEVELS
  end

  def steps
    first_step.self_and_descendants
  end

  def duration
    steps.map(&:duration).reduce(&:+)
  end

  def ingredients
    steps.map(&:ingredients).flatten.uniq
  end
end

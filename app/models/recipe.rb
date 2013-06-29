class Recipe < ActiveRecord::Base

  include Named

  DIFFICULTY_LEVELS = %w(easy medium difficult).freeze

  validates_inclusion_of :difficulty, in: DIFFICULTY_LEVELS

  def self.difficulty_levels
    DIFFICULTY_LEVELS
  end

end

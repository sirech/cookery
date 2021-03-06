class Recipe < ActiveRecord::Base

  include IsNamed

  belongs_to :author, class_name: User, foreign_key: 'user_id'
  validates_presence_of :author

  validates_numericality_of :servings, greater_than: 0

  has_and_belongs_to_many :categories

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures

  has_many :steps
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

  has_many :videos
  accepts_nested_attributes_for :videos, reject_if: :all_blank, allow_destroy: true

  # Difficulty
  DIFFICULTY_LEVELS = %w(easy medium difficult).freeze
  validates_inclusion_of :difficulty, in: DIFFICULTY_LEVELS

  def self.difficulty_levels
    DIFFICULTY_LEVELS
  end

  def picture
    if pictures.any?
      pictures.first
    else
      Picture.new
    end
  end

  def duration
    steps.map(&:duration).reduce(0, &:+)
  end

  def ingredients
    steps.map(&:ingredients).flatten.uniq
  end
end

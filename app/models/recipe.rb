class Recipe < ActiveRecord::Base

  include Named

  has_and_belongs_to_many :categories
  has_one :first_step, class_name: 'Step'
  accepts_nested_attributes_for :first_step

  has_attached_file :picture,
                    styles: { medium: '300x300!', thumb: '100x100!' },
                    convert_options: { thumb: '-quality 75 -strip' },
                    default_url: '/images/:style/pan.png'
  validates_attachment_size :picture, less_than: 3.megabytes
  validates_attachment_content_type :picture,
                                    content_type: %w(image/jpeg image/png)

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

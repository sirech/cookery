class Recipe < ActiveRecord::Base

  include IsNamed

  has_and_belongs_to_many :categories

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures

  has_many :steps, -> { order('position') }

  serialize :videos, Array
  validate :video_is_url

  before_save do |recipe|
    recipe.videos.map! do |video|
      if video =~ /\/watch\?v=/
        video.sub('watch?v=', 'embed/')
      else
        video
      end
    end
  end

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

  protected

  def video_is_url
    videos.each do |video|
      errors.add(:videos, "#{video} is not a valid url for a video") unless uri?(video)
    end
  end

  def uri?(url)
    uri = URI.parse(url)
    %w( http https ).include?(uri.scheme) && uri.host.include?('youtube')
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end

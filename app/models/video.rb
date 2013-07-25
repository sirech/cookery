class Video < ActiveRecord::Base
  validates_with VideoValidator

  before_save do |video|
    self.url.sub!('watch?v=', 'embed/') if self.url =~ /\/watch\?v=/
  end

end

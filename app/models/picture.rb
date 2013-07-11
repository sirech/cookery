class Picture < ActiveRecord::Base

  belongs_to :recipe

  has_attached_file :photo,
                    styles: { medium: '300x300!', thumb: '100x100!' },
                    convert_options: { thumb: '-quality 75 -strip' },
                    default_url: '/images/:style/pan.png'
  validates_attachment_size :photo, less_than: 2.megabytes
  validates_attachment_content_type :photo,
                                    content_type: %w(image/jpeg image/png)
end

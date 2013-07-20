class VideoValidator < ActiveModel::Validator
  def validate(record)
    unless uri?(record.url)
      record.errors[:url] << "#{record.url} is not a valid url for a video"
    end
  end

  private

  def uri?(url)
    uri = URI.parse(url)
    %w( http https ).include?(uri.scheme) && uri.host.include?('youtube')
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end

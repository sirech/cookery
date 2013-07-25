require 'spec_helper'

describe Video do
  let(:video) { Video.create url: 'https://www.youtube.com/watch?v=K729GqTf2pk' }

  describe '#url' do
    it 'should reject things that are not urls' do
      v = Video.new url: 'test'
      expect(v.valid?).to be_false
    end

    it 'should reject non-youtube urls' do
      v = Video.new url: 'http://vimeo.com'
      expect(v.valid?).to be_false
    end

    it 'should rewrite videos that can not be embedded' do
      expect(video.url).to_not match(/watch/)
    end
  end
end

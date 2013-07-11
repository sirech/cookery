require 'spec_helper'

describe Picture do

  let(:picture) { Picture.create caption: 'test pic', photo: Rails.root.join('spec', 'fixtures', 'pan.png').open }

  describe 'initialize' do
    it 'should create a valid picture' do
      expect(picture.valid?).to be_true
    end
  end

  describe 'photo' do

    it 'can be accessed' do
      expect(picture.photo).not_to be_nil
    end

    [:thumb, :medium].each do |style|
      it "generates a valid url for the style #{style}" do
        expect(picture.photo.url(style)).to match(%r(photos/.*/#{style}.png))
      end
    end
  end

end

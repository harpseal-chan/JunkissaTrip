require 'rails_helper'

RSpec.describe Feature, type: :model do
  let(:feature) { Feature.new(icon_name: 'icon', detail: '特徴') }

  context '有効な値の場合' do
    it 'featureが有効であること' do
      expect(feature).to be_valid
    end
  end

  context '無効な値の場合' do
    it 'icon_nameが空の場合、featureが無効であること' do
      feature.icon_name = ''
      expect(feature).not_to be_valid
    end

    it 'icon_nameが51文字以上の場合、featureが無効であること' do
      feature.icon_name = 'a' * 51
      expect(feature).not_to be_valid
    end

    it 'detailが空の場合、featureが無効であること' do
      feature.detail = ''
      expect(feature).not_to be_valid
    end

    it 'icon_nameが256文字以上の場合、featureが無効であること' do
      feature.detail = 'a' * 256
      expect(feature).not_to be_valid
    end
  end
end

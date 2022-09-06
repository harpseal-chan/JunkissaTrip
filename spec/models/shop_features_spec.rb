require 'rails_helper'

RSpec.describe ShopFeature, type: :model do
  let(:shop_feature) { FactoryBot.build(:shop_feature1) }

  context '有効な値の場合' do
    it 'shop_featureが有効であること' do
      expect(shop_feature).to be_valid
    end
  end

  context '無効な値の場合' do
    it 'shop_idが空の場合、shop_featureが無効であること' do
      shop_feature.shop_id = ''
      expect(shop_feature).not_to be_valid
    end

    it 'feature_idが空の場合、shop_featureが無効であること' do
      shop_feature.feature_id = ''
      expect(shop_feature).not_to be_valid
    end
  end

  context '重複した値が存在する場合' do
    it 'shop_featureが無効であること' do
      dup_shop_feature = shop_feature.dup
      shop_feature.save
      expect(dup_shop_feature).not_to be_valid
    end
  end
end

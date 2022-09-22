require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:shop) do
    Shop.new(name: '純喫茶',
             kana: 'じゅんきっさ',
             address: '住所',
             phone: '0000-0000-0000',
             opening: '10:00 - 20:00',
             closed: '水曜',
             smoking: '',
             access: '',
             payment: '')
  end

  context '有効な値で店舗登録' do
    it 'shopが有効であること' do
      expect(shop).to be_valid
    end
  end

  context 'nameカラムのバリデーション' do
    it 'nameが空の場合、shopが無効であること' do
      shop.name = ' '
      expect(shop).not_to be_valid
    end

    it 'nameが256文字以上の場合、shopが無効であること' do
      shop.name = "a" * 256
      expect(shop).not_to be_valid
    end
  end

  context 'addressカラムのバリデーション' do
    it 'addressが空の場合、shopが無効であること' do
      shop.address = ' '
      expect(shop).not_to be_valid
    end

    it 'addressが256文字以上の場合、shopが無効であること' do
      shop.address = "a" * 256
      expect(shop).not_to be_valid
    end

    it 'addressは一意であること' do
      duplicate_shop = shop.dup
      duplicate_shop.address = shop.address
      shop.save
      expect(duplicate_shop).not_to be_valid
    end
  end

  context 'phoneカラムのバリデーション' do
    it 'phoneが21文字以上の場合、shopが無効であること' do
      shop.phone = "a" * 21
      expect(shop).not_to be_valid
    end
  end

  context 'openingカラムのバリデーション' do
    it 'openingが256文字以上の場合、shopが無効であること' do
      shop.opening = "a" * 256
      expect(shop).not_to be_valid
    end
  end

  context 'closedカラムのバリデーション' do
    it 'closedが256文字以上の場合、shopが無効であること' do
      shop.closed = "a" * 256
      expect(shop).not_to be_valid
    end
  end

  context 'smokingカラムのバリデーション' do
    it 'smokingが256文字以上の場合、shopが無効であること' do
      shop.smoking = "a" * 256
      expect(shop).not_to be_valid
    end
  end

  context 'accessカラムのバリデーション' do
    it 'accessが256文字以上の場合、shopが無効であること' do
      shop.access = "a" * 256
      expect(shop).not_to be_valid
    end
  end

  context 'paymentカラムのバリデーション' do
    it 'paymentが256文字以上の場合、shopが無効であること' do
      shop.payment = "a" * 256
      expect(shop).not_to be_valid
    end
  end

  context 'kanaカラムのバリデーション' do
    it 'kanaが空の場合、shopが無効であること' do
      shop.kana = ' '
      expect(shop).not_to be_valid
    end

    it 'kanaが256文字以上の場合、shopが無効であること' do
      shop.kana = "a" * 256
      expect(shop).not_to be_valid
    end
  end
end

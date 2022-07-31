require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let!(:user) { FactoryBot.create(:harpseal) }
  let!(:shop) { FactoryBot.create(:shop) }
  let!(:bookmark) { Bookmark.new(user_id: user.id, shop_id: shop.id) }

  context '有効な値の場合' do
    it 'bookmarkが有効であること' do
      expect(bookmark).to be_valid
    end
  end

  context '重複した値の場合' do
    it 'bookmarkが無効であること' do
      duplicate_bookmark = bookmark.dup
      bookmark.save
      expect(duplicate_bookmark).not_to be_valid
    end
  end

  context 'user_idカラムのバリデーション' do
    it 'user_idが空の場合、bookmarkが無効であること' do
      bookmark.user_id = ' '
      expect(bookmark).not_to be_valid
    end
  end

  context 'shop_idカラムのバリデーション' do
    it 'shop_idが空の場合、bookmarkが無効であること' do
      bookmark.shop_id = ' '
      expect(bookmark).not_to be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:harpseal) }
  let(:shop) { FactoryBot.create(:shop1) }
  let(:comment) { Comment.new(user_id: user.id, shop_id: shop.id, content: 'コメント') }

  context '有効な値の場合' do
    it 'commentが有効であること' do
      expect(comment).to be_valid
    end
  end

  context '重複した値の場合' do
    it 'duplicate_commentが有効であること' do
      duplicate_comment = comment.dup
      comment.save
      expect(duplicate_comment).to be_valid
    end
  end

  context 'user_idカラムのバリデーション' do
    it 'user_idが空の場合、commentが無効であること' do
      comment.user_id = ' '
      expect(comment).not_to be_valid
    end
  end

  context 'shop_idカラムのバリデーション' do
    it 'shop_idが空の場合、commentが無効であること' do
      comment.shop_id = ' '
      expect(comment).not_to be_valid
    end
  end

  context 'contentカラムのバリデーション' do
    it 'contentが空の場合、commentが無効であること' do
      comment.content = ' '
      expect(comment).not_to be_valid
    end

    it 'contentが400文字を超える場合、commentが無効であること' do
      comment.content = 'a' * 401
      expect(comment).not_to be_valid
    end
  end
end

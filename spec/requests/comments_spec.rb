require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { FactoryBot.create(:harpseal) }
  let(:shop) { FactoryBot.create(:shop1) }

  describe "#create" do
    context 'ログアウト状態の場合' do
      it 'コメントを投稿できないこと' do
        expect do
          post shop_comments_path(shop), params: { comment: { user_id: user.id,
                                                              shop_id: shop.id,
                                                              content: 'コメント' } }
        end.not_to change(Comment, :count)
      end

      it 'ログイン画面にリダイレクトすること' do
        post shop_comments_path(shop), params: { comment: { user_id: user.id,
                                                            shop_id: shop.id,
                                                            content: 'コメント' } }
        expect(response).to redirect_to(login_url)
      end
    end

    context 'ログイン状態の場合' do
      before do
        log_in user
      end

      it 'コメントを投稿できること' do
        expect do
          post shop_comments_path(shop), params: { comment: { user_id: user.id,
                                                              shop_id: shop.id,
                                                              content: 'コメント' } }
        end.to change(Comment, :count).by(1)
      end

      it '複数回同じ店舗にコメントを投稿できること' do
        expect do
          2.times do
            post shop_comments_path(shop), params: { comment: { user_id: user.id,
                                                                shop_id: shop.id,
                                                                content: 'コメント' } }
          end
        end.to change(Comment, :count).by(2)
      end
    end
  end
end

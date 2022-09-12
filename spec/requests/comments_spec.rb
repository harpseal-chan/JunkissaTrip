require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { FactoryBot.create(:harpseal) }
  let!(:other_user) { FactoryBot.create(:spottedseal) }
  let!(:shop) { FactoryBot.create(:shop1) }

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

  describe "#destroy" do
    let!(:comment) { FactoryBot.create(:comment, user: user, shop: shop) }

    context 'ログアウト状態の場合' do
      it 'アカウントを削除できないこと' do
        expect do
          delete shop_comment_path(shop, comment)
        end.not_to change(Comment, :count)
      end

      it 'ログインページにリダイレクトすること' do
        delete shop_comment_path(shop, comment)
        expect(response).to redirect_to login_url
      end
    end

    context 'ログイン状態の場合' do
      before do
        log_in user
      end

      it 'アカウントを削除できること' do
        expect do
          delete shop_comment_path(shop, comment)
        end.to change(Comment, :count).by(-1)
      end

      it '店舗詳細ページにリダイレクトすること' do
        delete shop_comment_path(shop, comment)
        expect(response).to redirect_to shop_url(shop)
      end
    end
  end
end

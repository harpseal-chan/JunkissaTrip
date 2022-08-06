require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  let!(:user) { FactoryBot.create(:harpseal) }
  let(:shop) { FactoryBot.create(:shop1) }

  describe "#create" do
    describe 'ログアウト状態' do
      it 'ブックマーク登録できないこと' do
        expect do
          post shop_bookmarks_path(shop), params: { bookmark: { user_id: user.id,
                                                                shop_id: shop.id } }
        end.not_to change(Bookmark, :count)
      end

      it 'ログイン画面にリダイレクトすること' do
        post shop_bookmarks_path(shop), params: { bookmark: { user_id: user.id,
                                                              shop_id: shop.id } }
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'ログイン状態' do
      before do
        log_in user
      end

      context '有効な値の場合' do
        it 'ブックマーク登録できること' do
          expect do
            post shop_bookmarks_path(shop), params: { bookmark: { user_id: user.id,
                                                                  shop_id: shop.id } }
          end.to change(Bookmark, :count).by(1)
        end

        it 'Ajaxでブックマーク登録できること' do
          expect do
            post shop_bookmarks_path(shop), params: { bookmark: { user_id: user.id,
                                                                  shop_id: shop.id } }, xhr: true
          end.to change(Bookmark, :count).by(1)
        end
      end
    end
  end

  describe "#destroy" do
    context 'ログアウト状態' do
      it 'ブックマーク解除できないこと' do
        expect do
          delete shop_bookmarks_path(shop), params: { bookmark: { user_id: user.id,
                                                                  shop_id: shop.id } }
        end.not_to change(Bookmark, :count)
      end

      it 'ログイン画面にリダイレクトすること' do
        delete shop_bookmarks_path(shop)
        expect(response).to redirect_to(login_url)
      end
    end

    context 'ログイン状態' do
      before do
        log_in user
        post shop_bookmarks_path(shop), params: { bookmark: { user_id: user.id, shop_id: shop.id } }
      end

      it 'ブックマーク解除できること' do
        expect do
          delete shop_bookmarks_path(shop)
        end.to change(Bookmark, :count).by(-1)
      end

      it 'Ajaxでブックマーク解除できること' do
        expect do
          delete shop_bookmarks_path(shop), xhr: true
        end.to change(Bookmark, :count).by(-1)
      end
    end
  end
end

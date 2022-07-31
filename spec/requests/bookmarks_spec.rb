require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  describe "#create" do
    let!(:user) { FactoryBot.create(:harpseal) }
    let!(:shop) { FactoryBot.create(:shop) }

    describe 'ログアウト状態でブックマーク登録した場合' do
      it 'ログイン画面にリダイレクトすること' do
        post shop_bookmarks_path(shop.id), params: { bookmark: { user_id: user.id,
                                                                 shop_id: shop.id } }
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'ログイン状態' do
      context '有効な値の場合' do
        before do
          log_in user
        end

        it 'ブックマーク登録できること' do
          expect do
            post shop_bookmarks_path(shop.id), params: { bookmark: { user_id: user.id,
                                                                     shop_id: shop.id } }
          end.to change(Bookmark, :count).by(1)
        end
      end
    end
  end
end

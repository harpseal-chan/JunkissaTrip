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
end

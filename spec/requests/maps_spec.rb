require 'rails_helper'

RSpec.describe "Maps", type: :request do
  describe '#search' do
    context 'アクセスした場合' do
      before do
        get maps_path
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"マップ検索 | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('マップ検索')
      end
    end

    describe 'マップ検索' do
      let!(:match_shop) { FactoryBot.create(:shop1) }
      let!(:not_match_shop) { FactoryBot.create(:shop2) }

      context 'マーカーの位置から半径1km以内に店舗がある場合' do  
        it '条件に合う店舗が表示されること' do
          get maps_path, params: { lat_lng: { latitude: 35.723, longitude: 139.7687 }}
          expect(response.body).to include match_shop.name
          expect(response.body).not_to include not_match_shop.name
        end
      end

      context 'マーカーの位置から半径1km以内に店舗がない場合' do  
        it 'エラーメッセージが表示されること' do
          get maps_path, params: { lat_lng: { latitude: 0, longitude: 0 }}
          expect(response.body).to include '条件に合う純喫茶がありません'
        end
      end
    end
  end
end

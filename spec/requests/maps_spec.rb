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
  end
end

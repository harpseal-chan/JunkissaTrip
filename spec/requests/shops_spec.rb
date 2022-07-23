require 'rails_helper'

RSpec.describe "Shops", type: :request do
  describe "GET /shops #index" do
    context '正常にアクセスした場合' do
      before do
        get shops_path
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"店舗一覧 | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('店舗一覧')
      end
    end
  end
end

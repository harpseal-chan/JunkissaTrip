require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login #new" do
    context '正常にアクセスした場合' do
      it "レスポンス 200 OK を返すこと" do
        get login_path
        expect(response).to have_http_status :ok
      end
      it 'タイトルに"ログイン | 純喫茶Trip"が表示されること' do
        get login_path
        expect(response.body).to include full_title('ログイン')
      end
    end
  end
end

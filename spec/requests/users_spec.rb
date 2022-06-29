require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    context '正常にアクセスした場合' do
      it "レスポンス 200 OK を返すこと" do
        get signup_path
        expect(response).to have_http_status :ok
      end
      it 'タイトルに"新規登録 | 純喫茶Trip"が表示されること' do
        get signup_path
        expect(response.body).to include full_title('新規登録')
      end
    end
  end
end

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

  describe "DELETE /logout #destroy" do
    let(:user) { FactoryBot.create(:harpseal) }

    it "ログアウトできること" do
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      expect(logged_in?).to be_truthy

      delete logout_path
      expect(logged_in?).to be_falsy
    end
  end
end

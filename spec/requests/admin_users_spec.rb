require 'rails_helper'

RSpec.describe "AdminUsers", type: :request do
  describe "#index" do
    context '管理者ユーザーでアクセスした場合' do
      let(:admin_user) { FactoryBot.create(:harpseal) }

      before do
        log_in admin_user
        get admin_users_path
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"【管理】トップページ | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('【管理】ユーザー一覧')
      end
    end

    context '管理者ユーザー以外がアクセスした場合' do
      let(:not_admin_user) { FactoryBot.create(:phoca) }

      before do
        log_in not_admin_user
        get admin_users_path
      end

      it 'rootにリダイレクトすること' do
        expect(response).to redirect_to(root_url)
      end
    end
  end
end

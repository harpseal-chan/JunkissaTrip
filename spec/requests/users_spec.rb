require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup #new" do
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

  describe "POST /users #create" do
    context '無効な値の場合' do
      let(:invalid_user_params) do
        { user: { name: '',
                  email: 'user@invlid',
                  password: 'foo',
                  password_confirmation: 'bar' } }
      end

      it 'ユーザーを登録できないこと' do
        expect do
          post users_path, params: invalid_user_params
        end.not_to change(User, :count)
      end
    end

    context '有効な値の場合' do
      let(:valid_user_params) do
        { user: { name: 'Example User',
                  email: 'user@example.com',
                  password: 'password',
                  password_confirmation: 'password' } }
      end

      it 'ユーザーを登録できること' do
        expect do
          post users_path, params: valid_user_params
        end.to change(User, :count).by 1
      end

      it 'users/id にリダイレクトすること' do
        post users_path, params: valid_user_params
        user = User.last
        expect(response).to redirect_to user
      end

      it 'flashが表示されること' do
        post users_path, params: valid_user_params
        expect(flash).to be_any
      end

      it 'ログイン状態であること' do
        post users_path, params: valid_user_params
        expect(logged_in?).to be_truthy
      end
    end
  end
end

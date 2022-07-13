require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#new" do
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

  describe "#create" do
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

  describe "#update" do
    let(:user) { FactoryBot.create(:harpseal) }

    before do
      log_in user
    end
    
    context '/users/id/editにアクセスした場合' do
      it 'タイトルに"アカウント設定 | 純喫茶Trip"が表示されること' do
        get edit_user_path(user)
        expect(response.body).to include full_title('アカウント設定')
      end
    end

    context '無効な値で更新した場合' do

      before do
        @invalid_name = ''
        @invalid_email = 'invalid'
        @invalid_password = 'foo'
        @invalid_password_cfm = 'bar'
        patch user_path(user), params: { user: { name: @invalid_name,
                                                 email: @invalid_email,
                                                 password: @invalid_password,
                                                 password_confirmation: @invalid_password_cfm } }
      end

      it 'ユーザーの情報が変更されていないこと' do
        user.reload
        expect(user.name).not_to eq @invalid_name
        expect(user.email).not_to eq @invalid_email
        expect(user.password).not_to eq @invalid_password
        expect(user.password_confirmation).not_to eq @invalid_password_cfm
      end

      it 'editページが再描画されること' do
        expect(response.body).to include full_title('アカウント設定')
      end
    end

    context '有効な値で更新した場合' do
      before do
        @valid_name = 'foobar'
        @valid_email = 'foo@bar.com'
        @valid_password = ''
        @valid_password_cfm = ''
        patch user_path(user), params: { user: { name: @valid_name,
                                                 email: @valid_email,
                                                 password: @valid_password,
                                                 password_confirmation: @valid_password_cfm } }
      end

      it 'ユーザーの情報が更新されていること' do
        user.reload
        expect(user.name).to eq @valid_name
        expect(user.email).to eq @valid_email
      end

      it '/users/id にリダイレクトされること' do
        expect(response).to redirect_to user
      end

      it 'flashが表示されること' do
        expect(flash).to be_any
      end
    end
  end
end

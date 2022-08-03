require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe '#new' do
    context '正常にアクセスした場合' do
      before do
        get signup_path
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"新規登録 | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('新規登録')
      end
    end
  end

  describe '#create' do
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

  describe '#show' do
    let!(:user) { FactoryBot.create(:harpseal) }
    let!(:other_user) { FactoryBot.create(:phoca) }

    context 'ログアウト状態で/users/idにアクセスした場合' do
      before do
        get user_path(user)
      end

      it 'flashが空ではないこと' do
        expect(flash).not_to be_empty
      end

      it 'ログインページにリダイレクトすること' do
        expect(response).to redirect_to login_url
      end
    end

    context 'ログインしたユーザーの/users/idにアクセスした場合' do
      before do
        log_in user
        get user_path(user)
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"マイページ | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('マイページ')
      end
    end

    context '他のユーザーの/users/idにアクセスした場合' do
      before do
        log_in user
        get user_path(other_user)
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"ユーザー名 | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title(other_user.name)
      end
    end
  end

  describe '#update' do
    let(:user) { FactoryBot.create(:harpseal) }

    describe 'ログイン状態で更新' do
      before do
        log_in user
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

    describe 'ログアウト状態で更新' do
      before do
        patch user_path(user), params: { user: { name: user.name, email: user.email } }
      end

      it 'flashが空ではないこと' do
        expect(flash).not_to be_empty
      end

      it 'ログインページにリダイレクトすること' do
        expect(response).to redirect_to login_url
      end
    end

    describe '別のユーザーの情報を更新' do
      let(:other_user) { FactoryBot.create(:phoca) }

      before do
        log_in user
        patch user_path(other_user), params: { user: { name: other_user.name,
                                                       email: other_user.email } }
      end

      it 'flashが空ではないこと' do
        expect(flash).not_to be_empty
      end

      it 'rootにリダイレクトすること' do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe '#edit' do
    let(:user) { FactoryBot.create(:harpseal) }

    context 'ログイン状態で/users/id/editにアクセスした場合' do
      before do
        log_in user
        get edit_user_path(user)
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"アカウント設定 | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('アカウント設定')
      end
    end

    context 'ログアウト状態で/users/id/editにアクセスした場合' do
      before do
        get edit_user_path(user)
      end

      it 'flashが空ではないこと' do
        expect(flash).not_to be_empty
      end

      it 'ログインページにリダイレクトすること' do
        expect(response).to redirect_to login_url
      end
    end

    context '他のユーザの/users/id/editにアクセスした場合' do
      let(:other_user) { FactoryBot.create(:phoca) }

      before do
        log_in user
        get edit_user_path(other_user)
      end

      it 'flashが空ではないこと' do
        expect(flash).not_to be_empty
      end

      it 'rootにリダイレクトすること' do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe '#destroy' do
    let!(:user) { FactoryBot.create(:harpseal) }
    let!(:other_user) { FactoryBot.create(:phoca) }

    context 'ログアウト状態の場合' do
      it 'アカウントを削除できないこと' do
        expect do
          delete user_path(user)
        end.not_to change(User, :count)
      end

      it 'ログインページにリダイレクトすること' do
        delete user_path(user)
        expect(response).to redirect_to login_url
      end
    end

    context '他のユーザーのアカウントを削除した場合' do
      before do
        log_in user
      end

      it 'アカウントを削除できないこと' do
        expect do
          delete user_path(other_user)
        end.not_to change(User, :count)
      end

      it 'rootにリダイレクトすること' do
        delete user_path(other_user)
        expect(response).to redirect_to root_url
      end
    end

    context 'ログイン状態の場合' do
      before do
        log_in user
      end

      it 'アカウントを削除できること' do
        expect do
          delete user_path(user)
        end.to change(User, :count).by(-1)
      end

      it 'rootにリダイレクトすること' do
        delete user_path(user)
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'フレンドリーフォワーディング' do
    let(:user) { FactoryBot.create(:harpseal) }

    context 'ログイン前に編集ページへアクセスした場合' do
      it 'ログイン後に編集ページにリダイレクトすること' do
        get edit_user_path(user)
        log_in user
        expect(response).to redirect_to edit_user_path(user)
      end
    end

    context '次回ログイン時' do
      it 'ログイン後にデフォルトのユーザー詳細ページにリダイレクトすること' do
        get edit_user_path(user)
        log_in user
        log_out
        log_in user
        expect(response).to redirect_to user
      end
    end
  end
end

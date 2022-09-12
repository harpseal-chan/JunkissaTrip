require 'rails_helper'

RSpec.describe "AdminShops", type: :request do
  describe "#index" do
    context '管理者ユーザーでアクセスした場合' do
      let(:admin_user) { FactoryBot.create(:harpseal) }

      before do
        log_in admin_user
        get admin_shops_path
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"【管理】店舗一覧 | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('【管理】店舗一覧')
      end
    end

    context '管理者ユーザー以外がアクセスした場合' do
      let(:not_admin_user) { FactoryBot.create(:phoca) }

      before do
        log_in not_admin_user
        get admin_shops_path
      end

      it 'rootにリダイレクトすること' do
        expect(response).to redirect_to(root_url)
      end
    end

    context 'ログアウト状態でアクセスした場合' do
      it 'ログイン画面にリダイレクトすること' do
        get admin_shops_path
        expect(response).to redirect_to(login_url)
      end
    end
  end

  describe '#edit' do
    context '管理者ユーザーでアクセスした場合' do
      let(:admin_user) { FactoryBot.create(:harpseal) }
      let(:shop) { FactoryBot.create(:shop1) }

      before do
        log_in admin_user
        get edit_admin_shop_path(shop)
      end

      it "レスポンス 200 OK を返すこと" do
        expect(response).to have_http_status :ok
      end

      it 'タイトルに"【管理】店舗情報編集 | 純喫茶Trip"が表示されること' do
        expect(response.body).to include full_title('【管理】店舗情報編集')
      end
    end
  end

  describe '#update' do
    let(:admin_user) { FactoryBot.create(:harpseal) }
    let(:not_admin_user) { FactoryBot.create(:phoca) }
    let(:shop) { FactoryBot.create(:shop1) }

    describe '管理者ユーザーで店舗情報更新' do
      before do
        log_in admin_user
      end

      context '無効な値で更新した場合' do
        before do
          @invalid_name = ''
          @invalid_address = ''
          @invalid_phone = ''
          @invalid_opening = ''
          @invalid_closed = ''
          patch admin_shop_path(shop), params: { shop: { name: @invalid_name,
                                                   address: @invalid_address,
                                                   phone: @invalid_phone,
                                                   opening: @invalid_opening,
                                                   closed: @invalid_closed, } }
        end

        it '店舗情報が変更されていないこと' do
          shop.reload
          expect(shop.name).not_to eq @invalid_name
          expect(shop.address).not_to eq @invalid_address
          expect(shop.phone).not_to eq @invalid_phone
          expect(shop.opening).not_to eq @invalid_opening
          expect(shop.closed).not_to eq @invalid_closed
        end

        it 'editページが再描画されること' do
          expect(response.body).to include full_title('【管理】店舗情報編集')
        end
      end

      context '有効な値で更新した場合' do
        before do
          @valid_name = 'foobar'
          @valid_address = 'foobar'
          @valid_phone = 'foobar'
          @valid_opening = 'foobar'
          @valid_closed = 'foobar'
          patch admin_shop_path(shop), params: { shop: { name: @valid_name,
                                                   address: @valid_address,
                                                   phone: @valid_phone,
                                                   opening: @valid_opening,
                                                   closed: @valid_closed } }
        end

        it '店舗情報が更新されていること' do
          shop.reload
          expect(shop.name).to eq @valid_name
          expect(shop.address).to eq @valid_address
          expect(shop.phone).to eq @valid_phone
          expect(shop.opening).to eq @valid_opening
          expect(shop.closed).to eq @valid_closed
        end

        it 'admin_shops_urlにリダイレクトされること' do
          expect(response).to redirect_to admin_shops_url
        end
      end
    end

    describe '管理者以外のユーザーが店舗情報更新' do
      before do
        log_in not_admin_user
        @valid_name = 'foobar'
        @valid_address = 'foobar'
        @valid_phone = 'foobar'
        @valid_opening = 'foobar'
        @valid_closed = 'foobar'
        patch admin_shop_path(shop), params: { shop: { name: @valid_name,
                                                 address: @valid_address,
                                                 phone: @valid_phone,
                                                 opening: @valid_opening,
                                                 closed: @valid_closed } }
      end

      it 'rootにリダイレクトすること' do
        expect(response).to redirect_to root_url
      end
    end

    describe 'ログアウト状態で更新' do
      before do
        @valid_name = 'foobar'
        @valid_address = 'foobar'
        @valid_phone = 'foobar'
        @valid_opening = 'foobar'
        @valid_closed = 'foobar'
        patch admin_shop_path(shop), params: { shop: { name: @valid_name,
                                                 address: @valid_address,
                                                 phone: @valid_phone,
                                                 opening: @valid_opening,
                                                 closed: @valid_closed } }
      end

      it 'ログインページにリダイレクトすること' do
        expect(response).to redirect_to login_url
      end
    end
  end
end

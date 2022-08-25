require 'rails_helper'

RSpec.describe "Layouts", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'ヘッダー' do
    let!(:user) { FactoryBot.create(:harpseal) }

    it '店舗一覧のリンクが存在すること' do
      visit root_path
      expect(page).to have_link '店舗一覧', href: shops_path
    end

    context 'ログイン状態の場合' do
      before do
        log_in user
        visit root_path
      end

      it 'リンクがroot_pathのロゴが存在すること' do
        expect(page).to have_link '純喫茶Trip', href: root_path
      end

      it 'マイページのリンクが存在すること' do
        expect(page).to have_link 'マイページ', href: user_path(user)
      end

      it 'アカウント設定のリンクが存在すること' do
        click_link 'header-dropdown'
        expect(page).to have_link 'アカウント設定', href: edit_user_path(user)
      end

      it 'ログアウトのリンクが存在すること' do
        click_link 'header-dropdown'
        expect(page).to have_link 'ログアウト', href: logout_path
      end
    end

    context 'ログアウト状態の場合' do
      before do
        visit root_path
      end

      it 'ログインのリンクが存在すること' do
        expect(page).to have_link 'ログイン', href: login_path
      end

      it '新規登録のリンクが存在すること' do
        expect(page).to have_link '新規登録', href: signup_path
      end
    end

    describe '検査バー' do
      context 'トップページにアクセスした場合' do
        it '検索バーがトップページに表示され、ヘッダーの検索バーが非表示になること' do
          visit root_path
          expect(page).to have_selector '#top-search-bar'
          expect(page).not_to have_selector '#header-search-bar'
        end
      end

      context 'トップページ以外にアクセスした場合' do
        it 'ヘッダーの検索バーが表示されること' do
          visit shops_path
          expect(page).to have_selector '#header-search-bar'
        end
      end
    end
  end

  describe 'トップページ' do
    before do
      visit root_path
    end

    it '検索欄が存在すること' do
      visit root_path
      expect(page).to have_selector '.top-form-control'
    end
  end

  describe '店舗一覧ページ' do
    let!(:shops) { FactoryBot.create_list(:shop1, 30) }

    before do
      visit shops_path
    end

    it 'ページネーションが存在すること' do
      expect(page).to have_selector '.pagination'
    end

    it '各店舗の詳細リンクが存在すること' do
      Shop.page(1).each do |shop|
        expect(page).to have_link href: shop_path(shop)
      end
    end
  end

  describe '店舗詳細ページ' do
    let(:shop) { FactoryBot.create(:shop1) }

    before do
      visit shop_path(shop)
    end

    it '店舗情報がすべて表示されていること' do
      expect(page).to have_content shop.name
      expect(page).to have_content shop.address
      expect(page).to have_content shop.phone
      expect(page).to have_content shop.opening
      expect(page).to have_content shop.closed
    end

    it '店舗の地図（GoogleMap）が表示されていること' do
      expect(page).to have_selector '#map'
    end

    describe 'ブックマーク' do
      let!(:user) { FactoryBot.create(:harpseal) }

      context 'ログイン状態の場合' do
        before do
          log_in user
          visit shop_path(shop)
        end

        it 'ブックマーク登録/解除ボタンが表示されていること' do
          expect(page).to have_selector '.btn-bm'
          page.first(".btn-bm").click
          expect(page).to have_selector '.btn-ubm'
        end
      end
    end
  end

  describe 'ユーザー詳細ページ(マイページ)' do
    let!(:user) { FactoryBot.create(:harpseal) }
    let!(:shop) { FactoryBot.create(:shop1) }

    before do
      log_in user
      visit user_path(user)
    end

    it 'ユーザーの情報がすべて表示されていること' do
      expect(page).to have_content user.name
      expect(page).to have_content user.email
    end

    context 'ブックマークが0件の場合' do
      it '「ブックマークした店舗はありません」と表示されること' do
        expect(page).to have_selector '#bm-not-found'
      end
    end

    context 'ブックマークが1件以上ある場合' do
      before do
        @bookmark = FactoryBot.create(:bookmark, user: user, shop: shop)
        visit user_path(user)
      end

      it 'ブックマークした店舗が表示されること' do
        expect(page).to have_selector '.bm-shop'
        expect(page).to have_link href: shop_path(@bookmark.shop)
      end
    end

    context '投稿したコメントが0件の場合' do
      it '「投稿したコメントはありません」と表示されること' do
        expect(page).to have_selector '#cm-not-found'
      end
    end

    context '投稿コメントが1件以上ある場合' do
      before do
        @comment = FactoryBot.create(:comment, user: user, shop: shop)
        visit user_path(user)
      end

      it '投稿したコメントが表示されること' do
        expect(page).to have_selector '.user-comment'
        expect(page).to have_content @comment.content
        expect(page).to have_link href: shop_path(@comment.shop)
      end
    end
  end

  describe 'アイコン画像' do
    let(:attached_user) { FactoryBot.create(:harpseal) }
    let(:not_attached_user) { FactoryBot.create(:phoca) }

    context 'アイコン画像がアタッチされている場合' do
      before do
        log_in attached_user
      end

      it 'アタッチしたアイコン画像がマイページとヘッダーに表示されていること' do
        visit user_path(attached_user)
        expect(page).to have_selector("img[src$='test_avatar.png']", count: 2)
      end

      it 'アタッチしたアイコン画像がアカウント設定ページとヘッダーに表示されていること' do
        visit edit_user_path(attached_user)
        expect(page).to have_selector("img[src$='test_avatar.png']", count: 2)
      end
    end

    context 'アイコン画像がアタッチされていない場合' do
      before do
        log_in not_attached_user
      end

      it 'デフォルトアイコン画像がマイページとヘッダーに表示されていること' do
        visit user_path(not_attached_user)
        expect(page).to have_selector("#avatar-default", count: 2)
      end

      it 'デフォルトアイコン画像がアカウント設定ページとヘッダーに表示されていること' do
        visit edit_user_path(not_attached_user)
        expect(page).to have_selector("#avatar-default", count: 2)
      end
    end
  end
end

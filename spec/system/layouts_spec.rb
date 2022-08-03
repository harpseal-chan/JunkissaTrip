require 'rails_helper'

RSpec.describe "Layouts", type: :system do
  let!(:user) { FactoryBot.create(:harpseal) }

  before do
    driven_by(:rack_test)
  end

  describe 'ヘッダー' do
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
  end

  describe '店舗一覧ページ' do
    let!(:shops) { FactoryBot.create_list(:sample_shops, 30) }

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
    let(:shop) { FactoryBot.create(:shop) }

    before do
      log_in user
      visit shop_path(shop)
    end

    it '店舗情報がすべて表示されていること' do
      expect(page).to have_content shop.name
      expect(page).to have_content shop.address
      expect(page).to have_content shop.phone
      expect(page).to have_content shop.opening
      expect(page).to have_content shop.closed
    end

    context 'ブックマーク' do
      it 'ブックマーク登録/解除ボタンが表示されていること' do
        expect(page).to have_selector '.btn-bm'
        page.first(".btn-bm").click
        expect(page).to have_selector '.btn-ubm'
      end
    end
  end

  describe 'ユーザー詳細ページ(マイページ)' do
    let(:user) { FactoryBot.create(:harpseal) }

    before do
      log_in user
      visit user_path(user)
    end

    context 'プロフィール' do
      it 'ユーザーの情報がすべて表示されていること' do
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
    end
  end

  describe '404ページ' do
    it 'notfound-wrapperが存在すること' do
      visit users_path
      expect(page).to have_selector '#notfound-wrapper'
    end
  end
end

require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let!(:match_shop) { FactoryBot.create(:shop1) }
  let!(:not_match_shop) { FactoryBot.create(:shop2) }

  before do
    driven_by(:rack_test)
    visit shops_path
  end

  describe 'ヘッダーの検索バー' do
    before do
      visit shops_path
    end

    context '店舗名で検索' do
      it '条件に合う店舗のみ表示されること' do
        fill_in 'q[name_or_address_cont]', with: match_shop.name
        page.first(".header-search-btn").click
        expect(page).to have_content match_shop.name
        expect(page).not_to have_content not_match_shop.name
      end
    end

    context '条件に一致する店舗がない場合' do
      it '#shop-not-foundが表示されること' do
        fill_in 'q[name_or_address_cont]', with: 'not-found'
        page.first(".header-search-btn").click
        expect(page).to have_selector '#shop-not-found'
      end
    end

    context '住所で検索' do
      it '条件に合う店舗のみ表示されること' do
        fill_in 'q[name_or_address_cont]', with: match_shop.address
        page.first(".header-search-btn").click
        expect(page).to have_content match_shop.address
        expect(page).not_to have_content not_match_shop.address
      end
    end
  end

  describe 'トップページの検索バー' do
    before do
      visit root_path
    end

    context '店舗名で検索' do
      it '条件に合う店舗のみ表示されること' do
        fill_in 'q[name_or_address_cont]', with: match_shop.name
        page.first(".btn-search").click
        expect(page).to have_content match_shop.name
        expect(page).not_to have_content not_match_shop.name
      end
    end
  end
end

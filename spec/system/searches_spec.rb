require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let!(:match_shop) { FactoryBot.create(:shop1) }
  let!(:not_match_shop) { FactoryBot.create(:shop2) }

  before do
    driven_by(:rack_test)
    visit shops_path
  end

  describe '店舗一覧ページの絞り込み検索', js: true do
    before do
      visit shops_path
    end

    context '店舗名で検索' do
      it '条件に合う店舗のみ表示されること' do
        fill_in 'q[name_or_address_cont]', with: match_shop.name
        page.first(".btn-search").click
        expect(page).to have_content match_shop.name
        expect(page).not_to have_content not_match_shop.name
      end
    end

    # context '店舗の特徴を絞り込み検索' do
    #   it '条件に合う店舗のみ表示されること' do
    #     # find('#FilterAccordion').click
    #     find("#q_features_id_in_1").click
    #     click_button '検索'
    #     expect(page).to have_content match_shop.name
    #     expect(page).not_to have_content not_match_shop.name
    #   end
    # end
  end
end

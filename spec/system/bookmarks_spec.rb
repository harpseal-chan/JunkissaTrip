require 'rails_helper'

RSpec.describe "Bookmarks", type: :system do
  let(:user) { FactoryBot.create(:harpseal) }
  let!(:shop) { FactoryBot.create(:shop) }

  before do
    driven_by(:rack_test)
  end

  context 'ログアウト状態でブックマーク登録ボタン押下' do
    it 'flash(danger)が表示されること' do
      visit shop_path(shop)
      page.first(".btn-bm").click
      expect(page).to have_selector 'div.alert.alert-danger'
      visit signup_path
      expect(page).not_to have_selector 'div.alert.alert-danger'
    end
  end
end

require 'rails_helper'

RSpec.describe "Maps", type: :system do
  let!(:shop) { FactoryBot.create(:shop1) }

  before do
    driven_by(:rack_test)
  end

  context 'マップから探すボタンを２回クリックした場合' do
    it '同じ位置から店舗を検索できること' do
      visit maps_path
      click_button '周辺の純喫茶を探す'
      click_button '周辺の純喫茶を探す'
      expect(page).to have_content shop.name
    end
  end
end

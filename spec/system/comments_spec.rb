require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let!(:user) { FactoryBot.create(:harpseal) }
  let!(:shop) { FactoryBot.create(:shop1) }

  before do
    driven_by(:rack_test)
    log_in user
    visit shop_path(shop)
  end

  context 'ログイン状態でコメントを投稿した場合' do
    it '投稿したコメントが表示されること' do
      expect(page).not_to have_selector '.comment'
      click_button 'コメントを投稿する'
      fill_in 'コメント', with: 'コメント'
      click_button '投稿'
      expect(page).to have_selector '.comment'
    end
  end
end

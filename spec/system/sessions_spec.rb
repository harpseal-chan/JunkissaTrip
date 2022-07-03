require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:rack_test)
  end

  context '無効な値を入力した場合' do
    it 'flashが表示されること' do
      visit login_path
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログイン'
      expect(page).to have_selector 'div.alert.alert-danger'
      visit signup_path
      expect(page).not_to have_selector 'div.alert.alert-danger'
    end
  end
end

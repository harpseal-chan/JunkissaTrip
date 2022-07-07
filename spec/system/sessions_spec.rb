require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let(:user) { FactoryBot.create(:harpseal) }

  before do
    driven_by(:rack_test)
  end

  context '無効な値を入力してログインした場合' do
    it 'flashが表示されること' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'invalid'
      click_button 'ログイン'
      expect(page).to have_selector 'div.alert.alert-danger'
      visit signup_path
      expect(page).not_to have_selector 'div.alert.alert-danger'
    end
  end

  context '有効な値を入力してログインした場合' do
    it 'ヘッダー表示がログイン時の内容に変わっていること' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).not_to have_selector "a[href=\"#{login_path}\"]"
      expect(page).to have_selector "a[href=\"#{logout_path}\"]"
      expect(page).to have_selector "a[href=\"#{user_path(user)}\"]"
    end
  end
end

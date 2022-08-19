require 'rails_helper'

RSpec.describe "GuestSessions", type: :system do
  before do
    driven_by(:rack_test)
    visit login_path
    click_link 'ゲストログイン'
  end

  context 'ゲストログインした場合' do
    it 'flash[:success]が表示されること' do
      expect(page).to have_selector '.alert-success'
    end
  end

  context 'ゲストログインでアカウント設定ページにアクセスした場合' do
    it 'flash[:danger]が表示されること' do
      click_link 'header-dropdown'
      click_link 'アカウント設定'
      expect(page).to have_selector '.alert-danger'
    end
  end
end

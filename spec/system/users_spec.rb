require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'ユーザー新規登録' do
    context '無効な値の場合' do
      it 'エラーメッセージが表示されること' do
        visit signup_path
        fill_in 'ユーザー名', with: ''
        fill_in 'メールアドレス', with: 'user@invlid'
        fill_in 'パスワード', with: 'foo'
        fill_in 'パスワード（確認）', with: 'bar'
        click_button 'アカウント作成'
        expect(page).to have_selector 'div#error-explanation'
      end
    end
  end
end

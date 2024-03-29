require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'ユーザー新規登録' do
    before do
      visit signup_path
    end

    context '無効な値で登録した場合' do
      it 'エラーメッセージが表示されること' do
        fill_in 'ユーザー名', with: ''
        fill_in 'メールアドレス', with: 'user@invalid'
        fill_in 'パスワード', with: 'foo'
        fill_in 'パスワード（確認）', with: 'bar'
        click_button 'アカウント作成'
        expect(page).to have_selector 'div#error-explanation'
      end
    end

    context '有効な値で登録した場合' do
      it 'アカウントが1つ増加すること' do
        fill_in 'ユーザー名', with: 'valid'
        fill_in 'メールアドレス', with: 'user@valid.com'
        fill_in 'パスワード', with: 'foobar'
        fill_in 'パスワード（確認）', with: 'foobar'
        expect do
          click_button 'アカウント作成'
        end.to change(User, :count).by(1)
      end
    end
  end

  describe 'アカウント設定' do
    let!(:user) { FactoryBot.create(:harpseal) }

    before do
      log_in user
    end

    context '無効な値で更新した場合' do
      it 'エラーメッセージが表示されること' do
        visit edit_user_path(user)
        fill_in 'ユーザー名', with: ''
        fill_in 'メールアドレス', with: 'user@invlid'
        fill_in 'パスワード', with: 'foo'
        fill_in 'パスワード（確認）', with: 'bar'
        click_button '変更'
        expect(page).to have_selector 'div#error-explanation'
      end
    end
  end
end

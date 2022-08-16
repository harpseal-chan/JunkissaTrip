require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let!(:user) { FactoryBot.create(:harpseal) }
  let!(:other_user) { FactoryBot.create(:phoca) }
  let!(:shop) { FactoryBot.create(:shop1) }
  let!(:other_shop) { FactoryBot.create(:shop2) }

  before do
    driven_by(:rack_test)
  end

  describe 'コメント投稿' do
    describe 'ログイン状態' do
      before do
        log_in user
        visit shop_path(shop)
      end

      it 'コメント投稿ボタンが表示されること' do
        expect(page).to have_selector '.btn-pc'
      end
  
      context 'コメントを1件投稿した場合' do
        before do
          click_button 'コメントを投稿する'
          fill_in 'コメント', with: 'コメント'
          click_button '投稿'
        end
  
        it '投稿したコメントが表示されること' do
          expect(page).to have_selector '.comment'
        end
  
        it '「もっと見る」が表示されていないこと' do
          expect(page).not_to have_selector '#more-link'
        end
      end
  
      context '3件以上コメントを投稿した場合' do
        before do
          3.times do
            click_button 'コメントを投稿する'
            fill_in 'コメント', with: 'コメント'
            click_button '投稿'
          end
        end
  
        it '「もっと見る」が表示されてクリックすると消えること' do
          expect(page).to have_selector '#more-link'
          click_link 'more-link'
          expect(page).not_to have_selector '#more-link'
        end
  
        it 'コメントが2件のみ表示されること' do
          expect(page).to have_selector '.comment', count: 2
        end
      end
    end

    describe 'ログアウト状態' do
      before do
        visit shop_path(shop)
      end

      it 'コメント投稿ボタンが表示されないこと' do
        expect(page).not_to have_selector '.btn-pc'
      end
    end
  end

  describe 'コメント削除', js: true do
    describe 'ログイン状態' do
      before do
        log_in user
      end
    
      it '自身が投稿したコメントに削除アイコンが表示されること' do
        visit shop_path(shop)
        click_button 'コメントを投稿する'
        fill_in 'コメント', with: 'コメント'
        click_button '投稿'
        expect(page).to have_selector '.cm-delete'
      end

      it '他のユーザーが投稿したコメントに削除アイコンが表示されないこと' do
        comment_by_other_user = FactoryBot.create(:comment, user: other_user, shop: other_shop)
        visit shop_path(other_shop)
        expect(page).not_to have_selector '.cm-delete'
      end
    end

    describe 'ログアウト状態' do
      before do
        visit shop_path(shop)
      end
  
      it 'コメント削除アイコンが表示されないこと' do
        expect(page).not_to have_selector '.cm-delete'
      end
    end
  end
end

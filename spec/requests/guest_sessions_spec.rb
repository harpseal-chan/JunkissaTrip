require 'rails_helper'

RSpec.describe "GuestSessions", type: :request do
  it 'ゲストユーザーでアカウント設定ページにアクセスするとrootにリダイレクトすること' do
    post guest_login_path
    get edit_user_path(current_user)
    expect(response).to redirect_to root_url
  end
end

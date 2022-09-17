require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe 'current_userメソッド' do
    let(:user) { FactoryBot.create(:spottedseal) }
    before do
      remember(user)
    end

    it 'session[:user_id]がnilの場合、正しいユーザーを返すこと' do
      expect(current_user).to eq user
      expect(logged_in?).to be_truthy
    end

    it 'remember_digestカラムの値が間違っている場合、nilを返すこと' do
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to eq nil
    end
  end
end

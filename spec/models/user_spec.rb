require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'ExampleUser', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar') }

  context '有効な値でユーザー登録' do
    it 'userが有効であること' do
      expect(user).to be_valid
    end

    it 'emailが有効なフォーマットの場合、userが有効であること' do
      valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  context '無効な値でユーザー登録' do
    it 'nameが空の場合、userが無効であること' do
      user.name = ''
      expect(user).not_to be_valid
    end

    it 'emailが空の場合、userが無効であること' do
      user.name = ''
      expect(user).not_to be_valid
    end

    it 'nameが51文字以上の場合、userが無効であること' do
      user.name = "a" * 51
      expect(user).not_to be_valid
    end

    it 'emailが255文字以上の場合、userが無効であること' do
      user.name = format('%s@example.com', "a" * 244)
      expect(user).not_to be_valid
    end

    it 'emailが無効なフォーマットの場合、userが無効であること' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end

    it 'emailは一意であること' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it 'passwordが空の場合、userが無効であること' do
      user.password = user.password_confirmation = ' ' * 6
      expect(user).not_to be_valid
    end

    it 'passwordが5文字以下の場合、userが無効であること' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).not_to be_valid
    end
  end

  context 'emailのDB登録' do
    it 'emailは小文字でDBに登録されていること' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe 'authenticatedメソッド' do
    it 'remember_digestがnilの場合falseを返すこと' do
      expect(user.authenticated?('')).to be_falsy
    end
  end
end

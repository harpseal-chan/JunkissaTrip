require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'header' do
    it 'リンクがroot_pathのロゴが存在すること' do
      visit root_path
      expect(page).to have_link '純喫茶Trip', href: root_path
    end
  end
end

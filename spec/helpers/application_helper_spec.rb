require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_title' do
    let(:base_title) { '純喫茶Trip' }

    context '引数がない場合' do
      it 'ベースタイトルのみ表示されること' do
        expect(full_title).to eq base_title.to_s
      end
    end

    context '引数がある場合' do
      it '"引数の文字列 | ベースタイトル"が表示されること' do
        expect(full_title('Test')).to eq "Test | #{base_title}"
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    let(:base_title) { '純喫茶Trip' }

    it 'レスポンス 200 OK を返すこと' do
      get root_path
      expect(response).to have_http_status :ok
    end

    it 'タイトルが「純喫茶Trip」であること' do
      get root_path
      expect(response.body).to include full_title
    end
  end
end

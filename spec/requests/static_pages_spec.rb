require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it '正常にレスポンスを返すこと' do
      get root_path
      expect(response).to have_http_status :ok
    end

    it 'タイトルが「純喫茶Trip」であること' do
      get root_path
      expect(response.body).to include "純喫茶Trip"
    end
  end
end

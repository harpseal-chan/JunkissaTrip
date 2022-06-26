require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it '正常にレスポンスを返すこと' do
      get static_pages_home_path
      expect(response).to have_http_status :ok
    end
  end
end

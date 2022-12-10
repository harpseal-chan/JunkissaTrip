require 'rails_helper'

RSpec.describe "Maps", type: :system do
  let!(:shop) { FactoryBot.create(:shop1) }

  before do
    driven_by(:rack_test)
  end
end

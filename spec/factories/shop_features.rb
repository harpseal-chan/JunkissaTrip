FactoryBot.define do
  factory :shop_feature, class: ShopFeature do
    shop { FactoryBot.create(:shop1) }
    feature { FactoryBot.create(:feature) }
  end
end
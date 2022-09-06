FactoryBot.define do
  factory :shop_feature1, class: ShopFeature do
    shop { FactoryBot.create(:shop1) }
    feature { FactoryBot.create(:coffee) }
  end

  factory :shop_feature2, class: ShopFeature do
    shop { FactoryBot.create(:shop2) }
    feature { FactoryBot.create(:sweets) }
  end
end

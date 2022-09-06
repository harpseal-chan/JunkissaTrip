FactoryBot.define do
  factory :coffee, class: Feature do
    icon_name { "coffee-bean.svg" }
    detail { "コーヒーにこだわりあり" }
  end

  factory :sweets, class: Feature do
    icon_name { "cake.svg" }
    detail { "スイーツメニューが充実" }
  end
end

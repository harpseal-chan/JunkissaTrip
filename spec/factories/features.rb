FactoryBot.define do
  factory :feature, class: Feature do
    sequence(:icon_name) { |n| "icon-#{n}" }
    sequence(:detail) { |n| "detail-#{n}" }
  end
end

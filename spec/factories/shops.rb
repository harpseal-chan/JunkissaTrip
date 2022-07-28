FactoryBot.define do
  factory :shop, class: Shop do
    name { '純喫茶' }
    address { '住所' }
    phone { '000-0000-0000' }
    opening { '10:00 - 20:00' }
    closed { '日曜' }
  end

  factory :sample_shops, class: Shop do
    name { '純喫茶' }
    sequence(:address) { |n| "住所-#{n}" }
    phone { '000-0000-0000' }
    opening { '10:00 - 20:00' }
    closed { '日曜' }
  end
end

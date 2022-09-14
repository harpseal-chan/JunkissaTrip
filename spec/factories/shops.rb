FactoryBot.define do
  factory :shop1, class: Shop do
    sequence(:name) { |n| "純喫茶-#{n}" }
    sequence(:address) { |n| "住所-#{n}" }
    phone { '000-0000-0000' }
    opening { '10:00 - 20:00' }
    closed { '日曜' }
    images { Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png') }
  end

  factory :shop2, class: Shop do
    name { 'きっさ ふぉーか' }
    address { '大阪府' }
    phone { '000-0000-0000' }
    opening { '10:00 - 20:00' }
    closed { '日曜' }
  end
end

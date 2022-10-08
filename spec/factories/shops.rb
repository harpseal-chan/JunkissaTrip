FactoryBot.define do
  factory :shop1, class: Shop do
    sequence(:name) { |n| "純喫茶-#{n}" }
    sequence(:kana) { |n| "じゅんきっさ-#{n}" }
    sequence(:address) { |n| "住所-#{n}" }
    latitude { 1.23 }
    longitude { 1.23 }
    phone { '000-0000-0000' }
    opening { '10:00 - 20:00' }
    closed { '日曜' }
    smoking { '禁煙' }
    payment { '現金' }
    access { 'アクセス' }
    images { Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png') }
  end

  factory :shop2, class: Shop do
    name { 'きっさ ふぉーか' }
    kana { 'きっさ ふぉーか' }
    address { '大阪府' }
    latitude { 1.23 }
    longitude { 1.23 }
    phone { '000-0000-0000' }
    opening { '10:00 - 20:00' }
    closed { '日曜' }
  end
end

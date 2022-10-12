FactoryBot.define do
  factory :shop1, class: Shop do
    sequence(:name) { |n| "純喫茶-#{n}" }
    sequence(:kana) { |n| "じゅんきっさ-#{n}" }
    sequence(:address) { |n| "東京都-#{n}" }
    latitude { 35.681236 }
    longitude { 139.767725 }
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
    latitude { 34.70391145077607 }
    longitude { 135.49835595062686 }
    phone { '000-0000-0000' }
    opening { '10:00 - 20:00' }
    closed { '日曜' }
  end
end

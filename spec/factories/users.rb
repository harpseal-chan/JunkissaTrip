FactoryBot.define do
  factory :harpseal, class: User do
    name { 'たてごとあざらし' }
    email { 'harpseal@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    avatar { Rack::Test::UploadedFile.new('spec/fixtures/images/test_avatar.png', 'image/png') }
    admin { true }
  end

  factory :ringedseal, class: User do
    name { 'わもんあざらし' }
    email { 'ringedseal@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :spottedseal, class: User do
    name { 'ごまふあざらし' }
    email { 'spottedseal@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

FactoryBot.define do
  factory :harpseal, class: User do
    name { 'Harp Seal' }
    email { 'harpseal@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :phoca, class: User do
    name { 'Phoca' }
    email { 'phoca@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

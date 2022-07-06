FactoryBot.define do
  factory :harpseal, class: User do
    name { 'Harp Seal' }
    email { 'harpseal@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
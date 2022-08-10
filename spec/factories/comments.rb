FactoryBot.define do
  factory :comment, class: Comment do
    user { nil }
    shop { nil }
    content { 'コメント' }
  end
end

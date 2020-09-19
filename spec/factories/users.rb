FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "fff#{n}@fff.com" }
    password { 'password1010' }
    password_confirmation { 'password1010' }
    nickname { 'nickname' }
    family_name { 'family' }
    first_name { 'first' }
    postal_code { '1234567' }
    prefecture
    address { '新宿区' }

    trait :invalid do
      nickname { nil }
      image { nil }
      prefecture_id { 1 }
    end

    trait :valid do
      image { nil }
      prefecture_id { 1 }
    end
  end
end

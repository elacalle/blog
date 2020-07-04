FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.username }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end

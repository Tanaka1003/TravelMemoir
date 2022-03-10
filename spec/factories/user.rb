FactoryBot.define do
  factory :user do
    name { Faker::Lorem }
    age { Faker::Lorem }
    adress { Faker::Lorem }
  end
end
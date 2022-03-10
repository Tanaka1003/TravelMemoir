FactoryBot.define do
  factory :post do
    title { Faker::Lorem }
    destination { Faker::Lorem }
    body { Faker::Lorem }
  end
end
FactoryBot.define do
  factory :item do
    name                { Faker::Lorem.sentence }
    description         { Faker::Lorem.sentence }
    price               { Faker::Number.number(digits: 7) }
    category_id         { Faker::Number.between(from: 2, to: 11) }
    state_id            { Faker::Number.between(from: 2, to: 7) }
    burden_id           { Faker::Number.between(from: 2, to: 3) }
    prefecture_id       { Faker::Number.between(from: 2, to: 48) }
    delivery_period_id  { Faker::Number.between(from: 2, to: 4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

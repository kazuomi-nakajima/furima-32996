FactoryBot.define do
  factory :order_processing do
    token               { 'tok_abcdefghijk00000000000000000' }
    postal_code         { '000-0000' }
    prefecture_id       { Faker::Number.between(from: 2, to: 48) }
    municipal           { Gimei.city.kanji }
    address             { Gimei.town.to_s }
    building_name       { Faker::Address.building_number }
    phone_number        { '09012345678' }
  end
end

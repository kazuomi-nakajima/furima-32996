FactoryBot.define do
  factory :user do
    gimei = Gimei.name #'Gimei'名前を代入
    email                {Faker::Internet.free_email}
    nickname             {Faker::Internet.username}
    first_name           {gimei.first.kanji}
    last_name            {gimei.last.kanji}
    furigana_first_name  {gimei.first.katakana}
    furigana_last_name   {gimei.last.katakana}
    birth_date           {Faker::Date.between(from: '1930-01-01', to: '2016-12-31')}
    password = Faker::Internet.password(min_length: 4) + "1" + "a"
    password {password}
    password_confirmation {password}
  end
end

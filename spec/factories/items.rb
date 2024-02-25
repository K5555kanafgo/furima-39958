FactoryBot.define do
  factory :item do
    title             {"タイトル"}
    explanation       {Faker::Lorem.paragraph}
    category_id       { 1 }
    situation_id      { 1 }
    load_id           { 1 }
    prefecture_id     { 1 }
    number_of_day_id  { 1 }
    price             { 300 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

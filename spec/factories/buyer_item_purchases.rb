FactoryBot.define do
  factory :buyer_item_purchase do
    post_code           { '123-4567' }
    prefecture_id       { 1 }
    town_name           { '東京都江戸川区' }
    number              { '葛西1-1-1' }
    telephone_number    { '09012345678' }
    building_name       { '青山ビル' }
    token               { 'tok_abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end

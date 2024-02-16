FactoryBot.define do
    factory :user do
      nickname              {Faker::Name.initials(number: 2)}
      email                 {Faker::Internet.email}
      password              {Faker::Internet.password(min_length: 6)}
      password_confirmation {password}
      first_name            {"山田"}
      family_name           {"太郎"}
      read_first            {"ヤマダ"}
      read_family           {"タロウ"}
      birthday              {"2000-01-01"}
    end
  end
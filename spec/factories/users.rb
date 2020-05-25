FactoryBot.define do

  factory :user do
    nickname              {"フリマ太郎"}
    email                 {"ttt@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"山田"}
    first_name            {"太郎"}
    furigana_family       {"ヤマダ"}
    furigana_first        {"タロウ"}
    birthday              {"2000-12-25"}
  end

end
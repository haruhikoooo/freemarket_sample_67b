FactoryBot.define do

  factory :address do
    destination_family_name        {"山田"}
    destination_first_name         {"太郎"}
    destination_furigana_family    {"ヤマダ"}
    destination_furigana_first     {"タロウ"}
    zipcode                        {"012-3456"}
    prefecture_id                  {1}
    city                           {"名古屋市"}
    house_number                   {"4番地"}
    apartment_name                 {"フリマ名古屋"}
    tel                            {"012-345-6789"}
  end

end
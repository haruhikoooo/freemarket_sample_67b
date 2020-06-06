FactoryBot.define do
  factory :comment do
    comment {"コメント"}
    user
    good
  end
end
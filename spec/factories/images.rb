FactoryBot.define do
  factory :image do
    image                 { File.new("#{Rails.root}/spec/fixtures/test_image.jpg") }
    good_id            {1}
  end
end
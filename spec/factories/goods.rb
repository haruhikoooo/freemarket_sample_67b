FactoryBot.define do
  factory :good, class: Good do
    id                    {2}
    name                  {"A"}
    explanation           {"商品の説明"}
    brand                 {1}
    condition_id          {1}
    derivery_cost_id      {1}
    prefecture_id         {1}
    derivery_day_id       {1}
    price                 {10000}
    images {[build(:image)]}
    user
    after(:build) do |good|
      # create(:grand_child_category)のfactoryの中で、親の定義、さらに親の定義が始まる。
      # good.category_id = create(:grand_child_category).id

   
        # 親、子、孫を作成して、孫をitemのcategory_idに紐付ける
        parent_category = create(:category)
        child_category = parent_category.children.create(name: "hello")      
        grand_child_category = child_category.children.create(name: "world")
  
        good.category_id = grand_child_category.id



      # good.images.attach(io: File.open('spec/fixtures/test_image.jpg')
    end
  end
    factory :good_category, class: Good do
      id                    {2}
      name                  {"A"}
      explanation           {"商品の説明"}
      brand                 {1}
      condition_id          {1}
      derivery_cost_id      {1}
      prefecture_id         {1}
      derivery_day_id       {1}
      price                 {10000}
      images {[build(:image)]}
      user
     
  end
  
end
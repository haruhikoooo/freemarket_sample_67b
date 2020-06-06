# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

parents = CSV.read('db/parents.csv', headers: true)
children = CSV.read('db/children.csv')
grandchildren = CSV.read('db/grandchildren.csv')

parents.each do |parent|
  Category.create!(
    name: parent,
  )
end

children.each do |child,i|
  parent = Category.find(i)
  parent.children.create!(
    name: child,
  )
end

grandchildren.each do |grandchild,i|
  child = Category.find(i)
  child.children.create!(
    name: grandchild,
  )
end


# goods = CSV.read('db/goods_sample.csv')
# good = {}
# i = 1
# goods.each do |name, explanation, category_id, brand, condition_id, prefecture_id, derivery_day_id, derivery_cost_id, price, user_id, transaction_status_id|
#   good = Good.new()
#   good[:name] = name
#   good[:explanation] = explanation
#   good[:category_id] = category_id
#   good[:brand] = brand
#   good[:condition_id] = condition_id
#   good[:prefecture_id] = prefecture_id
#   good[:derivery_day_id] = derivery_day_id
#   good[:derivery_cost_id] = derivery_cost_id
#   good[:price] = price
#   good[:user_id] = user_id
#   good[:transaction_status_id] = transaction_status_id
#   good.save!(validate: false)
#   image = Image.new(good_id: i, image: open("#{Rails.root}/public/test/sample.png"))
#   image.save!(validate: false)
#   i = i+1
# end
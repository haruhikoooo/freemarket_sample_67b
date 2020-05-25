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
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# For performance testing only
500.times do |i|
  new_list = List.create(title: "Test List #{i}", user_id: 1)
  
  10.times do |j|
    new_item = new_list.items.create(name: "Test Item #{i}.#{j}", completed: false)
  end
end
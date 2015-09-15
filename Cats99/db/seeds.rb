# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
cat = Cat.create!(birth_date: "01-01-1900 10:00", color: 'purple', name: 'purple_cat',
  sex: "m", description: "This is a purple cat that someone described")

Cat.create!(birth_date: "01-01-2010 10:00", color: 'white', name: 'Whitey',
  sex: "m", description: "This is a cat that someone described")

Cat.create!(birth_date: "01-01-1975 10:00", color: 'black', name: 'Black_cat',
    sex: "f")

CatRentalRequest.create!(cat_id: cat.id, start_date: Time.now,        end_date: Time.now + 3600)
CatRentalRequest.create!(cat_id: cat.id, start_date: Time.now + 30,   end_date: Time.now + 3600)
CatRentalRequest.create!(cat_id: cat.id, start_date: Time.now - 90,   end_date: Time.now + 360)
CatRentalRequest.create!(cat_id: cat.id, start_date: Time.now + 400,  end_date: Time.now + 600)
CatRentalRequest.create!(cat_id: cat.id, start_date: Time.now + 9000, end_date: Time.now + 10000)

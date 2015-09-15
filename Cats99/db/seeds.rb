# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.create!(birth_date: "01-01-1900 10:00", color: 'purple', name: 'purple_cat',
  sex: "m", description: "This is a purple cat that someone described")

Cat.create!(birth_date: "01-01-2010 10:00", color: 'white', name: 'Whitey',
  sex: "m", description: "This is a cat that someone described")

Cat.create!(birth_date: "01-01-1975 10:00", color: 'black', name: 'Black_cat',
    sex: "f")

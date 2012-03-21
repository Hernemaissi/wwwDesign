# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  naiset    = Category.create("name" => "Naiset")
  miehet    = Category.create("name" => "Miehet")
  
  miehet1 = miehet.children.create("name" => "Smokki")
  miehet2 = miehet.children.create("name" => "Tummapuku")
  miehet3 = miehet.children.create("name" => "Frakki")
  miehet4 = miehet.children.create("name" => "Kengät")
  miehetkengät1 = miehet4.children.create("name" => "Lakerikengät")
  miehetkengät2 = miehet4.children.create("name" => "Nahkakengät")
  

  naiset1 = naiset.children.create("name" => "Iltapuku")
  naiset2 = naiset.children.create("name" => "Hääpuku")
  naiset3 = naiset.children.create("name" => "Juhlamekot")
  naiset4 = naiset.children.create("name" => "Kengät")
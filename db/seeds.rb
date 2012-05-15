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
  
  bonjourpuku = miehet.children.create("name" => "Bonjour-puku")
  frakki = miehet.children.create("name" => "Frakki")
  saketti = miehet.children.create("name" => "Saketti")
  smokki = miehet.children.create("name" => "Smokki")
  tummapuku = miehet.children.create("name" => "Tumma puku")
  kengät = miehet.children.create("name" => "Kengät")
  

  naiset1 = naiset.children.create("name" => "Iltapuku")
  naiset3 = naiset.children.create("name" => "Juhlamekko")
  naiset2 = naiset.children.create("name" => "Morsiuspuku")
  naiset4 = naiset.children.create("name" => "Kengät")
  
  parts = Part.create([
    { name: 'Takki', categories: [smokki, tummapuku, frakki, saketti]}, 
    { name: 'Housut', categories: [smokki, tummapuku, frakki, saketti] }, 
    { name: 'Liivi', categories: [smokki, tummapuku, frakki, saketti]}, 
    { name: 'Paita', categories: [smokki, tummapuku, frakki, saketti]}, 
    { name: 'Solmio', categories: [smokki, tummapuku, saketti]}, 
    { name: 'Kalvosinnapit', categories: [smokki, tummapuku, frakki, saketti]}, 
    { name: 'Plastron', categories: [tummapuku, frakki, saketti]}, 
    { name: 'Rinnusnapit', categories: [frakki]}, 
    { name: 'Vyö', categories: [smokki, frakki]}])
  

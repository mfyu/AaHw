# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
kl = House.create(address: 'King''s Landing')
Person.create!(name: 'Joffrey', house_id: kl.id)
Person.create!(name: 'Cersei', house_id: kl.id)

wf = House.create(address: 'Winterfell')
Person.create!(name: 'Sansa', house_id: wf.id)
Person.create!(name: 'Arya', house_id: wf.id)
Person.create!(name: 'Bran', house_id: wf.id)
Person.create!(name: 'Rickon', house_id: wf.id)
Person.create!(name: 'Hodor', house_id: wf.id)
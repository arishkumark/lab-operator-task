# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Device.create!(name: "ABJ-NM", category: 'balance', vendor: 'Kern').tap do |device|
  device.channels.create! name: 'weight', unit: 'mg'
end

Device.create!(name: "Entris Series", category: 'balance', vendor: 'Sartorius').tap do |device|
  device.channels.create! name: 'weight', unit: 'mg'
end

Device.create!(name: "Hei-VAP", category: 'stirrer', vendor: 'Heidolph').tap do |device|
  device.channels.create! name: 'rotation', unit: 'rpm'
  device.channels.create! name: 'temperature', unit: 'C'
end

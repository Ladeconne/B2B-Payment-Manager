# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p "Deleting all transactions and all profiles"
Transaction.destroy_all
Profile.destroy_all

p "Creating two new profiles"
2.times do
  profile = Profile.new
  profile.name = "So Frost"

  10.times do
    invoice = Transaction.new
    invoice.type = "invoice"
    invoice.date = Faker::Date.backward(days: 250)
    invoice.amount = Faker::Number.between(from: 30, to: 600)
  end
end

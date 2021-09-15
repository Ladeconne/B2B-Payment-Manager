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
User.destroy_all

puts "creating fake users..."
user = User.new(email: "user@user.com", password: "password")
user.save!


p "Creating a new profile"
profile = Profile.new
profile.name = "So Frost"
profile.user = user
profile.save!
p "Profile created successfully"

p "Creating 10 new invoices"
100.times do
  invoice = Transaction.new
  invoice.nature = "invoice"
  invoice.date = Faker::Date.backward(days: 90)
  invoice.amount = Faker::Number.between(from: 30, to: 600)
  invoice.company_paid = "N/A"
  invoice.profile = profile
  invoice.save!
end
p "Invoices created successfully"

p "Creating 10 new payments"
100.times do
  payment = Transaction.new
  payment.nature = "payment"
  payment.company_paid = Faker::Company.name
  payment.description = Faker::Lorem.sentences(number: 3, supplemental: true)
  payment.date = Faker::Date.backward(days: 90)
  payment.amount = Faker::Number.between(from: 30, to: 600)
  payment.profile = profile
  payment.save!
end
p "Payments created successfully"

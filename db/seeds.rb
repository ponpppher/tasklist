# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
first_user = User.create!(name:"first", email:"a@gmail.com", password_digest:"$2a$10$d25tU6TfNbfwWO0PEuAayON5IqhotKdGcqd7FfiUt5Fxtnf2Ip4sq", admin:true)
second_user = User.create!(name:"second", email:"b@gmail.com", password_digest:"$2a$10$d25tU6TfNbfwWO0PEuAayON5IqhotKdGcqd7FfiUt5Fxtnf2Ip4sq")
10.times do |_n|
  #  name = Faker::Pokemon.name
  #  email = Faker::Internet.email
  #  password = "password"
  #  User.create!(name:name,
  #    email:email,
  #    password:password,
  #    password_confirmation:password,
  #  )

  label = Faker::Pokemon.unique.name
  Label.create!(name: label, user_id: first_user.id)
end

5.times do |_n|
  label = Faker::Pokemon.unique.name
  Label.create!(name: label, user_id: second_user.id)
end
